class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.create(user_params)
        if @user.save
            @user.libraries << Library.new(name: Library.uncategorized_books)
            @user.libraries << Library.new(name: Library.books_loaned_to_user)
            @user.libraries << Library.new(name: Library.books_user_is_loaning)
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
