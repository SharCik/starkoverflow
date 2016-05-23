class UserTag < ActiveRecord::Base
  validates_uniqueness_of :user_id, :scope => :tag_id

  belongs_to :user
  belongs_to :tag
end
