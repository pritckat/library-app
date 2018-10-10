class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.create(user_params)
        if @user.save
            @user.libraries << Library.new(name: "New")
            @user.libraries << Library.new(name: "On Loan")
            @user.libraries << Library.new(name: "Loaned")
            session[:user_id] = @user.id
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
