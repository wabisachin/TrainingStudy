class CardsController < ApplicationController
    def list
        @cards = Card.where(user_id: current_user.id).order(created_at: "DESC")
        # binding.pry
    end
    
    def new
        @card = Card.new()
    end
    
    def new_multiple
    end
    
    def create_multiple
        # formから受け取った複数登録のデータをcards_columnに代入
        cards_column = params[:cards]
        cards_column.each do |card| 
            Card.create(user_id: current_user.id, front_word: card[:front_word], back_word: card[:back_word])
        end
        # binding.pry
        redirect_to "/cards_list/#{current_user.id}"
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
        if selected_ids.nil?
            flash[:notice] = "単語カードを選択してください"
            redirect_to "/cards_list/#{current_user.id}"
        end
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
        redirect_to :list
        
    end
    
    def destroy_multiple
        # 選択されたレコードの繰り返し処理
        ids = params[:selected_ids]
        # binding.pry
        if ids.nil?
            flash[:notice] = "単語カードを選択してください"
        else
            ids = params[:selected_ids]
            ids.each do |id|
                card=Card.find(id)
                card.destroy
            end
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
