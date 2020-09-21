class SchedulesController < ApplicationController

  # GET: /schedules
  get "/schedules" do
    erb :"/schedules/index.html"
  end

  # GET: /schedules/new
  get "/schedules/new" do
    erb :"/schedules/new.html"
  end

  # POST: /schedules
  post "/schedules" do
    redirect "/schedules"
  end

  # GET: /schedules/5
  get "/schedules/:id" do
    erb :"/schedules/show.html"
  end

  # GET: /schedules/5/edit
  get "/schedules/:id/edit" do
    erb :"/schedules/edit.html"
  end

  # PATCH: /schedules/5
  patch "/schedules/:id" do
    redirect "/schedules/:id"
  end

  # DELETE: /schedules/5/delete
  delete "/schedules/:id/delete" do
    redirect "/schedules"
  end
end
