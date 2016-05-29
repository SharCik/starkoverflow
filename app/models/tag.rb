class Tag < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :question_tags
  has_many :user_tags
  has_many :questions, through: :question_tags
  has_many :users, through: :user_tags
end
