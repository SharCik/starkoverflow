class Answer < ActiveRecord::Base

	belongs_to :question , :foreign_key => :question_id, class_name: 'Question'
	belongs_to :users, :foreign_key => :user_id
	
end
