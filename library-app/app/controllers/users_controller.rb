class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.create(user_params)
        if @user.save
            redirect_to user_path(@user)
        else
            render new_user_path
        end
    end

    def show
        @user = User.find(params[:id])
    end

    def index
        @users = User.all 
    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
