class ServersController < ApplicationController

  get "/servers" do
    erb :"/servers/index.html"
  end

  get "/servers/new" do
    erb :"/servers/new.html"
  end

  post "/servers" do
    redirect "/servers"
  end

  get "/servers/:id" do
    erb :"/servers/show.html"
  end

  get "/servers/:id/edit" do
    erb :"/servers/edit.html"
  end

  patch "/servers/:id" do
    redirect "/servers/:id"
  end

  delete "/servers/:id/delete" do
    redirect "/servers"
  end
end
