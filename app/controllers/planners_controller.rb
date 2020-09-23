class PlannersController < ApplicationController
  get 'planners/index' do
    if logged_in?
      @user = current_user[:id]
      @tables = current_user.planners
     
      erb :'planners/index'
    else 
      redirect '/'
    end
  end

  get '/planners/new' do
    erb :'/planners/new'
  end

  post '/planners' do
    @table = Planner.new(params)
    @table[:user_id] = current_user[:id]
    @table[:heading] = @table[:heading][0].split(",")
    @table[:row] = []
    @table.save
   
    redirect "/planners/#{@table.id}/edit"
  end

  get '/planners/:id' do
    # check if table belongs to user
    # @table = Planner.find(params[:id])
    erb :'/planners/show'
  end

  get '/planners/:id/edit' do
    # if their table isnt theirs show error
    @table = Planner.find(params[:id])
    
    erb :'/planners/edit'
  end

  patch "/planners/:id/edit" do
    binding.pry
    # @table = Planner.find(params[:id])
    # if !params[:heading].empty?
      @table.update(params)
    # end
    erb :"/planners/#{@table.id}/edit"
  end

  delete "/planners/:id/delete" do
    @table = Planner.find(params[:id])
    @table.destroy

    redirect "/planners/index"
  end
end
