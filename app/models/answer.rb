class Answer < ActiveRecord::Base
	has_many :votes
	belongs_to :question , :foreign_key => :question_id, class_name: 'Question'
	belongs_to :users, :foreign_key => :user_id
	
end
