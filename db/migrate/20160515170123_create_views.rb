class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.integer :user_id
      t.integer :question_id 
      t.integer :views , :default => 0
    end
  end
end
