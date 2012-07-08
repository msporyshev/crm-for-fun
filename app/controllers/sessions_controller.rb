class SessionsController < ApplicationController
  skip_before_filter :redirect_to_sign_in_page_if_not_signed_in
  skip_before_filter :redirect_to_root_with_correct_subdomain_if_subdomain_is_invalid

  def new
  end

  def create
    if user = User.authenticate(params[:email], params[:password])
      sign_in(user)
      redirect_to root_url(:subdomain => user.subdomain), :notice => "Signed In"
    else
      redirect_to new_session_url, :alert => "Invalid user/password combination"
    end
  end

  def destroy
    cookies.delete(:s_id, :domain => "HOSTING_DOMAIN_NAME")

    if current_user
      current_user.expires_at = Time.now
      current_user.save(validate: false)
    end

    current_user = nil
    redirect_to root_url, notice: "Signed out!"
  end

end
