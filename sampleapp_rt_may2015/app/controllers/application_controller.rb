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
end