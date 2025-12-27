class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :posts_path
  validates :content, presense: true
end
