class SessionsController < ApplicationController
  def create
    unless @auth = Authentication.find_from_hash(auth_hash)
      @auth = Authentication.create_from_hash(auth_hash, self.current_user)
    end

    self.current_user = @auth.user
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

  protected
  def auth_hash
    request.env["omniauth.auth"]
  end
  # This is necessary since Rails 3.0.4
  # See https://github.com/intridea/omniauth/issues/185
  # and http://www.arailsdemo.com/posts/44
  def handle_unverified_request
    true
  end
end
