class Post < ApplicationRecord
  # 値が空でないこと・最大35文字以下であること
  validates :title, presence: true, length: { maximum: 35 }
  # 値が空でないこと・最大270文字以下であること
  validates :body, presence: true, length: { maximum: 270 }

  belongs_to :user
end
