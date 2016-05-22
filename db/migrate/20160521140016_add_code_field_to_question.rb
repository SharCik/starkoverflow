class AddCodeFieldToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :code, :text 
  end
end
