class UsersController < ApplicationController
  get '/login' do 
    erb :'index/login'
  end

  post '/login' do 
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/users/:id'
    else 
      redirect to :'users/signup'
    end
  end

  get '/signup' do 
    erb :'index/signup'
  end

  post '/signup' do 
    
  end
end
