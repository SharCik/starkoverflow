class Star < ActiveRecord::Base
	belongs_to :question
	validates_uniqueness_of :question_id
end
