class Post < ApplicationRecord
  # 値が空でないこと・最大30文字以下であること
  validates :title, presence: { message: "を入力してください" }, length: { maximum: 30, message: "は35文字以内で入力してください" }
  # 値が空でないこと・最大250文字以下であること
  validates :body, presence: { message: "を入力してください" }, length: { maximum: 250, message: "は270文字以内で入力してください" }
  # 画像が投稿されていること
  validates :post_image_url, presence: true

  belongs_to :user
  mount_uploader :post_image, PostImageUploader
end
