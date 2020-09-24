class SessionController < ApplicationController
    get '/signup' do 
        if logged_in?
            redirect :'/planners'
        else
            erb :'sessions/signup'
        end
    end

    post '/signup' do 
        if params[:username].empty? || params[:password].empty?
            @error = true 
            erb :'sessions/signup'
        else 
            user = User.find_by(:username => params[:username])

            if user 
                @username_taken = true
                erb :'sessions/signup' 
            else 
                user = User.create(params)
                session[:user_id] = user[:id]

                redirect '/planners'        
            end
        end
    end

    get '/login' do 
        if logged_in?
            redirect '/planners'
        else
            erb :'sessions/login'
        end
    end

    post '/login' do 
        if params[:username].empty? || params[:password].empty?
            @error = true
            erb :'sessions/login'
        else 
            user = User.find_by(:username => params[:username])

            if user && !user.authenticate(params[:password])
                @wrong_password = true 
                erb :'sessions/login'
            elsif user && user.authenticate(params[:password])
                session[:user_id] = user[:id]
                redirect '/planners'
            else 
                @no_user = true 
                erb :'sessions/login'
            end
        end
    end

    get '/logout' do
        logout
        redirect '/'
      end
end