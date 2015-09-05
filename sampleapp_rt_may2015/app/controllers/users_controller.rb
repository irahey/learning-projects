class UsersController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
    before_action :correct_user,   only: [:edit, :update]       # A correct_user before filter to protect the edit/update pages.
    before_action :admin_user,     only: :destroy


    def index
      @users = User.paginate(page: params[:page])
    end


    #The Users controller with a show action with a debugger
    def show
        @user = User.find(params[:id])
        #debugger
        #remmove the # if you want to debug
    end
    
    def new
        #Adding an @user variable to the new action.
        @user = User.new
    end
    
    # A create action that can handle signup failure. 
    def create
      @user = User.new(user_params)
      if @user.save
        @user.send_activation_email
        flash[:info] = "Please check your email to activate your account."
        redirect_to root_url
      else
        render 'new'
      end
    end
    
    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User deleted"
      redirect_to users_url
    end
=begin NOTES
        @user = User.new(params[:user])
                ^^^IS MOSTLY EQUIVALENT TO----vvvv
        @user = User.new(name: "Foo Bar", email: "foo@invalid",
                         password: "foo", password_confirmation: "bar")
  the former is less secure
=end
    def edit
        @user = User.find(params[:id])
    end
    
    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            flash[:success] = "Profile updated"
            redirect_to @user
          # Handle a successful update.
        else
          render 'edit'
        end
    end


  #Using strong parameters in the create action.
  #Preferred technique: to use so-called strong parameters in the controller layer >> using attr_accessible in the model layer 
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location      #The store_location method in Listing 9.27 puts the requested URL in the session variable under the key :forwarding_url
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
 
   # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
