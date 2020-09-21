class UsersController < ApplicationController
  get '/login' do 
    if logged_in?
      @user = current_user[:username]
      erb :'users/show'
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
        session[:user_id] = user.id
        redirect '/users/show'
      else 
        @no_user = true 
        erb :'users/login'
      end
    end
  end

  get '/signup' do 
    if logged_in?
      erb :'user/show'
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
        session[:user_id] = @user.id

        redirect 'users/show'        
      end
    end
  end

  get '/logout' do
    logout
    redirect '/'
  end

  get '/users/show' do 
    if logged_in?
      @user = current_user[:username]
      erb :'users/show'
    else 
      redirect '/'
    end
  end
end
