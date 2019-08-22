class WeakpointController < ApplicationController
    # 苦手登録を切り替えるアクション
    def change
        card = Card.find(params[:card_id])
        if card.weakness == 0
            # 数値1で苦手チェック
            card.weakness = 1
        else
            card.weakness = 0
        end
        card.save
        redirect_to "/cards_list/#{current_user.id}"
    end
end
