class AddColumnsToComment < ActiveRecord::Migration
  def change
  	add_column :comments, :user_id, :integer
  	add_column :comments, :text, :text
  	add_column :comments, :question_id, :integer
  end
end
