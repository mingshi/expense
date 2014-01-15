class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    #protect_from_forgery with: :exception

    before_filter :check_session
    
    skip_before_filter :check_session, :only=> [:login, :do_login]
    
    include ExpenseHelper

    def check_session
        unless session[:uid]
            redirect_to login_url
        end
    end
end
