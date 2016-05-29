class Question < ActiveRecord::Base
	validates :title, presence: true , uniqueness: true
	validates :description, presence: true

	has_many :answers
	has_many :votes
	has_many :views
	has_one :star
	belongs_to :users, :foreign_key => :user_id
  has_many :question_tags
  has_many :tags, through: :question_tags

	def self.search(search)
		where("title ILIKE ? OR description ILIKE ?", "%#{search}%", "%#{search}%")
	end
end
