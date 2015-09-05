class EntriesController < ApplicationController
  
  def index
    @entries = Entry.all
  end
  def show
    @entry = Entry.find(params["id"])
  end

  def create
    entry_params = params["entry"].permit("title", "contents")
    entry = Entry.create(entry_params)
    #render(:text => params.inspect)
    redirect_to(entry_path(entry))
  end
    
  def new
    @entries = Entry.new
  end
  def edit
    @entry = Entry.find(params["id"])
  end
  def update
    entry_params = params["entry"].permit("title", "contents")
    entry = Entry.find(params["id"])
    entry.update(entry_params)
    redirect_to(entry_path(entry))
  end
end
