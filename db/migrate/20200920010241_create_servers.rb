class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :name 
      t.string :channels
      t.string :user_id
      t.timestamps null: false
    end
  end
end
