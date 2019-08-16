class TrainingController < ApplicationController
    def learning
        user = User.find(params[:id])
        @cards = user.cards
    end
end
