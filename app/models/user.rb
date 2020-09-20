class User < ActiveRecord::Base
    has_secure_password
    has_many :friends
    has_many :posts
    has_many :servers
    # has_many :channels, through :servers
end
