class Card < ApplicationRecord
    validates :user_id, presence: true 
    validates :front_word, presence: true 
    validates :back_word, presence: true 
    
end
