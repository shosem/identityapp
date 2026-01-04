class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  def visible_comments
    comments.where(deleted: false).order(created_at: :asc)
  end

  mount_uploader :post_image, PostImageUploader
end
