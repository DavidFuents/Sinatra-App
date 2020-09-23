class UsersController < ApplicationController
  get '/login' do 
    if logged_in?
      redirect 'users/index'
    else
      erb :'users/login'
    end
  end

  post '/login' do 
    if params[:username].empty? || params[:password].empty?
      @error = true
      erb :'users/login'
    else 
      user = User.find_by(:username => params[:username])

      if user && !user.authenticate(params[:password])
        @wrong_password = true 
        erb :'users/login'
      elsif user && user.authenticate(params[:password])
        session[:user_id] = current_user.id
        redirect '/users/index'
      else 
        @no_user = true 
        erb :'users/login'
      end
    end
  end

  get '/signup' do 
    if logged_in?
      erb :'users/index'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do 
    if params[:username].empty? || params[:password].empty?
      @error = true 
      erb :'users/signup'
    else 
      user = User.find_by(:username => params[:username])

      if user 
        @username_taken = true
        erb :'users/signup' 
      else 
        @user = User.new(params)
        @user.save
        session[:user_id] = current_user.id

        redirect 'users/index'        
      end
    end
  end

  get '/logout' do
    logout
    redirect '/'
  end

  get '/users/index' do 
    if logged_in?
      @user = current_user[:id]
      @tables = current_user.schedules
     
      erb :'users/index'
    else 
      redirect '/'
    end
  end
end
