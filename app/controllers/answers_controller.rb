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
            # ここからテストの結果を受けて苦手判定を行う処理(cardインスタンスのweakpointカラムの数値0or1を決定)
            # countNumに直近何回分のデータを取ってくるかの数値を代入
            countNum = 5
            card = Card.find(answer["id"])
            # cardモデルのインスタンスメソッドcorrect_rateから正答率を取得
            correct_rate = card.correct_rate
            # 同じくcardモデルが持つcorrect_times_counterメソッドから直近の正解数を取得
            collect_times = card.correct_times_counter(countNum)
            total_times = card.answers.length
            # ここから条件分岐。解答回数10回かつ合計正答率80%以上、または直近連続正解５回で苦手チェックを外す。下回れば苦手チェック
            if total_times == 10 && correct_rate >= 0.8
                card.weakness = 1
                card.save
                # binding.pry
            elsif collect_times == countNum
                card.weakness = 1
                card.save
            else
                card.weakness = 0
                card.save
                # binding.pry
            end
            
            
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
