class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper      #Including the Sessions helper module into the Application controller.
  def hello
    render text: "¡Hola, mundo!"
  end
  def goodbye
    render text: "Goodbye World!"
  end
  private
      # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location # Adding store_location to the logged-in user before filter.
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end