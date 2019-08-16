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
        # @cardsの中に選択されたレコードをリストとして格納
        # @cards=[]
        
        # 選択されたリストのid
        selected_ids= params[:selected_ids]
        @selected_cards=Card.where(id: selected_ids)
        # 繰り返し処理で一つずつ格納
        # selected_ids.each do |id|
        #     card=Card.find(id)
        #     @cards.push(card)
        # end
    end
    
    def update_multiple
        ids = params[:selected_ids]
        # 選択されたレコードの変更内容を順番に反映
        ids.each do |id|
            card = Card.find(id)
            card.update(selected_card_params("card_id_#{id}"))
        end
        redirect_to "/cards_list/#{current_user.id}"
    end
    
    def destroy_multiple
        # 選択されたレコードの繰り返し処理
        # binding.pry
        ids = params[:selected_ids]
        ids.each do |id|
            card=Card.find(id)
            card.destroy
        end
        redirect_to "/cards_list/#{current_user.id}"
        
    end
    # プライペート関数
    private 
    def card_params
        params.require(:card).permit(:user_id, :front_word, :back_word,:favorite)
    end
    
    def selected_card_params(card_id)
        params.require(card_id).permit(:id,:front_word,:back_word,:favorite)
    end
    
end
