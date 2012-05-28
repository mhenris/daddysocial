class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  mount_uploader :image, PostImageUploader

  def feed_comments
    comments.last(3)
  end
end
