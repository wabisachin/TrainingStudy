class TrainingController < ApplicationController
    def learning
        user = User.find(params[:id])
        @cards = user.cards
    end
    
    def test
        user = User.find(params[:user_id])
        @cards = user.cards.pluck(:front_word,:back_word)
        
    end
end
