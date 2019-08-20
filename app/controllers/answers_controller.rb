class AnswersController < ApplicationController
    def add_results
        # JSON形式のテスト結果をハッシュとして取得してresultに代入
        answer_result = params_result[:answer_result]
        #JSON形式のデータをJSONモデルのparseメソッドを使って配列に変換
        answer_result_hash = JSON.parse(answer_result)
        #テストの結果データを繰り返し処理を用いてAnswerモデルに格納していく
        answer_result_hash.each do |answer|
            Answer.create(card_id: answer["id"], result: answer["result"])
        end
        
        # binding.pry
        redirect_to root_path
    end
    
    private
    def params_result
        params.permit(:answer_result)
    end
end
