class Answer < ApplicationRecord
    
    validates :card_id, presence: true
    validates :result, presence: true
    
    belongs_to :card
    
end
