class Server < ActiveRecord::Base
    has_many :users 
    has_many :channels
    has_many :posts, through: :channels
end
