class Post < ApplicationRecord
  # 値が空でないこと・最大35文字以下であること
  validates :title, presence: { message: "を入力してください" }, length: { maximum: 35, message: "は35文字以内で入力してください" }
  # 値が空でないこと・最大270文字以下であること
  validates :body, presence: { message: "を入力してください" }, length: { maximum: 270, message: "は270文字以内で入力してください" }


  belongs_to :user
  mount_uploader :post_image, PostImageUploader
end
