class Card < ApplicationRecord
    validates :user_id, presence: true 
    validates :front_word, presence: true 
    validates :back_word, presence: true 
    # アソシエーションの記述
    belongs_to :user
    has_many :answers, dependent: :destroy
    
     #直近の正答率を返す関数
    def correct_rate
        answers_all = self.answers
        total_times = answers_all.length
        correct_times = answers_all.where(result: 1).length
        rate = (correct_times.to_f/total_times).round(2)
        return rate
    end
    
    # 指定した単語カードについて直近n回で何回正解したか返す関数
    def correct_times_counter(n)
        count = 0
        # 直近の解答データを新しい順に取得
        answers_latest = self.answers.order(created_at: "DESC")
        for i in 0..n-1 do 
            if i >= answers_latest.length
                break
            end
            answer = answers_latest[i]
            if answer.result == 1
                count+=1
            end
        end
        
        return count
    end
end
