class User < ApplicationRecord
  has_secure_password
  validates :name, presence:true, length: { minimum:4, maximum:12 }, uniqueness:true
  validates :highest_rank, presence: true, length: { maximum:12 }
  validates :password, length: { minimum:4 }

  has_many :posts, dependent: :destroy
  has_many :comments

  def admin?
    admin
  end
end
