class QuestionTag < ActiveRecord::Base
  validates_uniqueness_of :question_id, :scope => :tag_id

	belongs_to :question
	belongs_to :tag
end
