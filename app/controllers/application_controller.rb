class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :redirect_to_sign_in_page_if_not_signed_in

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

    def redirect_to_sign_in_page_if_not_signed_in
      unless current_user
        redirect_to new_session_path
      end
    end
end
