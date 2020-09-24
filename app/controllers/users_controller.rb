class UsersController < ApplicationController
    get '/error' do 
        erb :'/users/error'
    end

    get '/notfound' do 
      erb :'/users/notfound' 
    end 
end