class UserImage < ActiveRecord::Base
  attr_accessible :user, :private, :image
  mount_uploader :image, UserImageUploader
  belongs_to :user
end
