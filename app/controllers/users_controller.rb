class UsersController < ApplicationController
  get '/login' do 
    if logged_in?
      erb :'users/page'
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
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect '/users/page'
      else
        redirect '/signup'
      end
    end
  end

  get '/signup' do 
    if logged_in?
      erb :'user/page'
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

        redirect 'users/page'        
      end
    end
  end

  get '/logout' do
    logout
    redirect '/'
  end

  get '/users/page' do 
    erb :'users/page'
  end
end
