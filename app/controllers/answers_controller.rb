class AnswersController < ApplicationController
    def add_results
        # JSON形式のテスト結果をハッシュとして取得してresultに代入
        answer_result = params_result[:answer_result]
        #JSON形式のデータをJSONモデルのparseメソッドを使って配列に変換
        answer_result_hash = JSON.parse(answer_result)
        #テストの結果データを繰り返し処理を用いてAnswerモデルに格納していく
        answer_result_hash.each do |answer|
            # cardに紐づいた結果データanswer_allのレコード数が10個より少ない場合は記録を追加、１０以上なら一番古いデータを消す
            answers_all = Answer.where(card_id: answer["id"]) 
            if answers_all.length >= 10
                # answerを古い順に並べて一番古いレコードを削除
                answer_oldest = answers_all.order(created_at: "ASC").first
                answer_oldest.destroy
            end
            
            Answer.create(card_id: answer["id"], result: answer["result"])
            # binding.pry
        end
    
        # binding.pry
        redirect_to "/cards_list/#{current_user.id}"
    end
    
    private
    def params_result
        params.permit(:answer_result)
    end
end
