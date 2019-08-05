class CardsController < ApplicationController
    def list
        @cards = Card.all.order(created_at: "DESC")
    end
    
    def new
        @card = Card.new()
    end
    
    def update
        card=Card.find(params[:id])
        card.update(card_params)
        redirect_to "/cards_list/#{current_user.id}"
    end
    
    def create
        Card.create(card_params)
        redirect_to "/cards_list/#{current_user.id}"
    end
    
    def destroy
        card=Card.find(params[:id])
        card.destroy
        redirect_to "/cards_list/#{current_user.id}"
    end
    
    def edit_multiple
    end
    # プライペート関数
    private 
    def card_params
        params.require(:card).permit(:user_id,:front_word, :back_word,:favorite)
    end
end
