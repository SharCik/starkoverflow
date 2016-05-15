class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.integer :user_id
      t.integer :question_id 
      t.integer :answer_id 
    end
  end
end
