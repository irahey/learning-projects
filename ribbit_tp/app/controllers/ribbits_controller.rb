class RibbitsController < ApplicationController
    def create
      @ribbit = Ribbit.new(params[:ribbit])  
      @ribbit.userid = current_user.id</p>
     
      if @ribbit.save
          redirect_to current_user 
      else
          flash[:error] = "Problem!"
          redirect_to current_user
      end
    end
    def index
        @ribbits = Ribbit.all include: :user  #The first line fetches all the ribbits and their associated users
        @ribbit = Ribbit.new        #creates the new ribbit instance (this page will have a ribbit form)
    end
end
