class AddFieldForCodeToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :code, :text 
  end
end
