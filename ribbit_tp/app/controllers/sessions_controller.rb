class SessionsController < ApplicationController
  def new
  end

  def create
      user = User.find_by_username(params[:username]) #We use the find_by_username method on the User class to retrieve the user with the provided username
      if user && user.authenticate(params[:password]) #we call the authenticate method, passing it the password. This method was added as part of the use_secure_password feature
          session[:userid] = user.id  #we can set the user_id session variable to the user's ID.
          redirect_to rooturl, notice: "Logged in!"
      else
          flash[:error] = "Wrong Username or Password."
          redirect_to root_url
      end
  end

  def destroy
    session[:userid] = nil
    redirect_to root_url, notice: "Logged out."
  end
end
