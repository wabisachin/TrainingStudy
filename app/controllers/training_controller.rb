class TrainingController < ApplicationController
    def learning
        user = User.find(params[:id])
        @cards = user.cards
    end
    
    def test
        user = User.find(params[:user_id])
        @cards = user.cards.pluck(:id,:front_word,:back_word).map{|w| {id: w[0],front_word: w[1],back_word: w[2]}}
        
    end
end
