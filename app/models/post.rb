class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  mount_uploader :image, PostImageUploader

  def importance
  end
end
