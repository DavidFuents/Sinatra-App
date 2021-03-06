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
      @table = Planner.find_by(id: params[:id]) 
      
      if @table && @table[:user_id].to_i == current_user[:id] 
        erb :'/planners/show'
      elsif !@table
        redirect '/notfound'
      else 
        redirect '/error'
      end
    else 
      redirect '/'
    end
  end

  get '/planners/:id/edit' do
    if logged_in?
      @table = Planner.find_by(id: params[:id])

      if  @table && @table[:user_id].to_i == current_user[:id] 
        erb :'/planners/edit'
      elsif !@table
        redirect '/notfound'
      else 
        redirect '/error'
      end
    else 
      redirect '/'
    end
  end

  post '/planners/:id/edit' do 
    @table = Planner.find_by(id: params[:id])

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
    @table = Planner.find_by(id: params[:id])
    
    if @table[:row].empty? 
      redirect "/planners/#{@table.id}/edit"
    else 
      @row = []
      @item_index = []

      params[:planner][:row].each do |item|
        if item == ""
          nil
        else
          @row << item.strip
          @item_index << params[:planner][:row].index(item)
        end 
      end
     
      params[:planner][:row].clear
     
      if !(params[:planner][:row_id].to_i > @table[:row].count)
        @edit_row = @table[:row][params[:planner][:row_id].to_i - 1]

        @row.each_with_index do |item, index|
          @edit_row[@item_index[index]] = item 
        end

        @table[:row].each do |row|
          params[:planner][:row] << row
        end
        
        @table.update(params[:planner].except(:row_id))
        redirect "/planners/#{@table.id}/edit"
      else 
        redirect "/planners/#{@table.id}/edit" #add an error message
      end
    end
  end

  delete "/planners/:id/delete" do
    if logged_in?
      @table = Planner.find_by(id: params[:id])
      @table.destroy

      redirect '/planners'
    else  
      redirect '/'
    end
  end

  get '/planners/:id/:anything' do 
    erb :'/users/404'
  end
end
