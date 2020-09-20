require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  end

  get "/" do
    if logged_in?
      redirect 'users/page'
    else
      erb :'/index'
    end
  end

  helpers do 
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id:session[:user_id]) if session[:user_id]
    end

    def logout 
      session.clear
    end
  end
end
