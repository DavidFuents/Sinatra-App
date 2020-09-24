class PlannersController < ApplicationController
  get '/planners' do
    if logged_in?
      @tables = current_user.planners
     
      erb :'planners/index'
    else 
      redirect '/'
    end
  end

  get '/planners/new' do
    if logged_in?
      erb :'/planners/new'
    else  
      redirect '/'
    end
  end

  post '/planners/new' do
    @table = Planner.new(params)
    @table[:user_id] = current_user[:id]
    @table[:heading] = @table[:heading][0].split(",")
    @table[:row] = []
    @table.save
   
    redirect "/planners/#{@table.id}/edit"
  end

  get '/planners/:id' do
    if logged_in?
      @table = Planner.find(params[:id])
    
      if @table[:user_id] == current_user[:id]
        redirect :'/users/error'
      else  
        erb :'/planners/show'
      end
    else 
      redirect '/'
    end
  end

  get '/planners/:id/edit' do
    if logged_in?
      @table = Planner.find(params[:id])
      
      erb :'/planners/edit'
    else 
      redirect '/'
    end
  end

  post '/planners/:id/edit' do 
    @table = Planner.find(params[:id])

    if params[:planner].include?(:row)
      @row = []

      params[:planner][:row].each do |item|
        @row << item.strip
      end

      params[:planner][:row].clear

      @table[:row].each do |row|
        params[:planner][:row] << row
      end

      params[:planner][:row] << @row
      @table.update(params[:planner])
    end

    redirect "planners/#{@table.id}/edit"
  end

  patch "/planners/:id/edit" do
    binding.pry
    @table = Planner.find(params[:id])
    @table.update(params[:planner])

    redirect :"/planners/#{@table.id}/edit"
  end

  delete "/planners/:id/delete" do
    if logged_in?
      @table = Planner.find(params[:id])
      @table.destroy

      redirect '/planners'
    else  
      redirect '/'
    end
  end
end
