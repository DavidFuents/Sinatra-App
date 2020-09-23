class Schedule < ActiveRecord::Base
    belongs_to :users
    serialize :heading
    serialize :row
end 
