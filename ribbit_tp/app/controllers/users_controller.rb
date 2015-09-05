class UsersController < ApplicationController
    def user_params
      params.require(:user).permit(:avatar_url, :username, :email, :password, :name, :password_confirmation)
    end
    def new
        if current_user
            redirect_to buddies_path    #If a logged-in user goes to the root URL, we need to redirect them to /buddies
        else
            @user = User.new
        end
    end
    
    def create
      @user = User.new(user_params)
     
      if @user.save
        session[:user_id] = @user.id #autonatically logs in after user is created
        redirect_to @user, notice: "Thank you for signing up for Ribbit!"   #This actually redirects to the path for that user, which will be /users/
      else
        render 'new' #we re-render the /users/new path and display any validation errors. We also pre-populate the form fields with the the user's previously provided information. 
      end
    end
    def show
      @user = User.find(params[:id])
      @ribbit = Ribbit.new
      
      #relationship instance to manipulate relationship
      @relationship = Relationship.where(   #initializes a blank Relationship instance if no records are found that match the where parameters
          follower_id: current_user.id,   
          followed_id: @user.id
      ).first_or_initialize if current_user   #we only want to do this if there is a current_user
    end
    def index   #list all the registered users
     @users = User.all
    end
    def buddies #where a user goes to view the ribbits of the people they follow
      if current_user
          @ribbit = Ribbit.new
          buddies_ids = current_user.followeds.map(&:id).push(current_user.id)
          @ribbits = Ribbit.find_all_by_user_id buddies_ids
      else
          redirect_to root_url    
      end
    end
    
end
