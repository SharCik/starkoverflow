class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password

  has_many :answers
  has_many :questions

  mount_uploader :picture, PictureUploader



end
