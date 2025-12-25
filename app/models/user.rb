class User < ApplicationRecord
  has_secure_password
  validates :name,:highest_rank, presence:true
  has_many :posts

  def admin?
    admin
  end
end
