class Question < ActiveRecord::Base
	validates :title, presence: true , uniqueness: true
	validates :description, presence: true

	has_many :answers
	has_many :votes
	has_many :views
	belongs_to :users, :foreign_key => :user_id

	def self.search(search)
		where("title ILIKE ? OR description ILIKE ?", "%#{search}%", "%#{search}%")
	end
end
