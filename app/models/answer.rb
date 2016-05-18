class Answer < ActiveRecord::Base
	has_many   :votes
	belongs_to :question
	belongs_to :users
  
  validates :answer, presence: true
end
