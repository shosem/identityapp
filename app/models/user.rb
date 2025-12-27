class User < ApplicationRecord
  has_secure_password
  validates :name,:highest_rank, presence:true
  has_many :posts, dependent: :destroy
  has_many :comments

  def admin?
    admin
  end
end
