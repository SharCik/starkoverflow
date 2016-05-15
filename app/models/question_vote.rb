class QuestionVote < ActiveRecord::Base
	validates_uniqueness_of :user_id, :scope => :question_id, :scope => :direction
end
