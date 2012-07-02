class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  protected

    def current_user=(user)
      @current_user = user
    end

    def current_user
      @current_user ||= User.authenticate_with_sid(cookies[:s_id])
    end

    def sign_in(user)
      cookies.permanent[:s_id] = user.secure_id
      current_user = user
    end
end
