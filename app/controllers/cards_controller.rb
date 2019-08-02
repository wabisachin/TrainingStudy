class CardsController < ApplicationController
    def list
        @cards = Card.all.order(created_at: "DESC")
    end
    
    def new
        @card = Card.new()
    end
    
    def create
        Card.create(card_params)
        redirect_to :root
    end
    # プライペート関数
    private 
    def card_params
        params.require(:card).permit(:user_id, :front_word, :back_word)
    end
end
