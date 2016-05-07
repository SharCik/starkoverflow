class Question < ActiveRecord::Base
	validates :title, presence: true , uniqueness: true
	validates :description, presence: true

	has_many :answers
end
