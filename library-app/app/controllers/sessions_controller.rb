class SessionsController < ApplicationController

    def new
        @user = User.new
    end

    def create
        #raise params
        @user = User.find_by(username: params[:user][:username])
        if @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render login_path
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to login_path
    end
end
