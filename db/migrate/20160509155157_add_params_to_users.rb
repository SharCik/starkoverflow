class AddParamsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :country, :string
  	add_column :users, :picture, :string
  end
end
