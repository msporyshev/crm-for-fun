class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate(params[:email], params[:password])
      sign_in(user)
      redirect_to root_url, :notice => "Signed In"
    else
      redirect_to new_session_url, :alert => "Invalid user/password combination"
    end
  end

  def destroy
    cookies.delete(:s_id)

    if current_user
      current_user.expires_at = Time.now
      current_user.save(validate: false)
    end

    current_user = nil
    redirect_to root_url, notice: "Signed out!"
  end

end
