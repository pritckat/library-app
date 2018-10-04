module ApplicationHelper

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
        !!current_user
    end

    def add_logout_button
        if logged_in?
            link_to "Log Out", logout_path, method: :delete
        end
    end

end
