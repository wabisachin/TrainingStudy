class UsersController < ApplicationController
    def show
        @user = User.find(current_user.id)
        # binding.pry
    end
    
    def update
        user = User.find(params[:id])
        user.update(update_params)
        # binding.pry
        redirect_to user_path(user)
    end
    
    private
    def update_params
        params.require(:user).permit(:name,:image,:email)
    end
end
