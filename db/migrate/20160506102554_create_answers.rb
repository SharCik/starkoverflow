class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :question_id 
      t.text :answer 
      t.integer :rating , :default => 0

      t.timestamps null: false
    end
  end
end
