class AddStarToAnswer < ActiveRecord::Migration
  def change
  	add_column :answers, :star, :boolean , :default => false
  end
end
