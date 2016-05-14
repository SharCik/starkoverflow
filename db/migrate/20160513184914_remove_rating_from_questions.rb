class RemoveRatingFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :rating, :integer
  end
end
