require 'pry'

class SchedulesController < ApplicationController
  get '/schedules/new' do
    erb :'/schedules/new'
  end

  post '/schedules' do
    @table = Schedule.new(params)
    @table[:user_id] = current_user.id
    @table[:heading] = @table[:heading][0].split(",")
    @table.save

    redirect "/schedules/#{@table.id}/edit"
  end

  get "/schedules/:id" do
    erb :"/schedules/show"
  end

  get '/schedules/:id/edit' do
    @table = Schedule.find(params[:id])
    
    erb :'/schedules/edit'
  end

  patch "/schedules/:id" do
    redirect "/schedules/:id"
  end

  delete "/schedules/:id/delete" do
    redirect "/schedules"
  end
end
