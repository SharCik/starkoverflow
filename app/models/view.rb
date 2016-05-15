class View < ActiveRecord::Base
	belongs_to :questions
	validates_uniqueness_of :user_id, :scope => :question_id
end
