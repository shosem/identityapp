class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :content, presence: true, length: { maximum: 65_535 }

  # 削除処理（レコード消さずにフラグだけ）
  def soft_destroy
    update(deleted: true)
  end
end
