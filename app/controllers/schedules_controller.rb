require 'pry'

class SchedulesController < ApplicationController
  get '/schedules/new' do
    erb :'/schedules/new'
  end

  post '/schedules' do
    @table = Schedule.new(params)
    @table[:user_id] = current_user[:id]
    @table[:heading] = @table[:heading][0].split(",")
    @table[:row] = []
    @table.save
   
    redirect "/schedules/#{@table.id}/edit"
  end

  get '/schedules/:id' do
    # check if table belongs to user
    @table = Schedule.find(params[:id])
    erb :'/schedules/show'
  end

  get '/schedules/:id/edit' do
    # if their table isnt theirs show error
    @table = Schedule.find(params[:id])
    
    erb :'/schedules/edit'
  end

  patch "/schedules/:id/edit" do
    binding.pry
    # @table = Schedule.new(params[:id])
    # if !params[:heading].empty?
      @table.update(params)
    # end
    erb :"/schedules/#{@table.id}/edit"
  end

  delete "/schedules/:id/delete" do
    @table = Schedule.find(params[:id])
    @table.destroy

    redirect "/schedules"
  end
end
