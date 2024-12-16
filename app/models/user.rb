class User < ApplicationRecord
  authenticates_with_sorcery!

  # 最低3文字以上必要
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  # password_confirmation と一致すること
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  # 値が空でないこと（nilや空文字でない）
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  # 値が空でないこと・最大100文字以下であること
  validates :name, presence: true, length: { maximum:100 }
  # 値が空でないこと・ユニークな値であること
  validates :email, presence: true, uniqueness: true
  # 属性の値が一意であり重複していないこと（nil は除く）
  validates :reset_password_token, uniqueness: true, allow_nil: true

  has_many :posts, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
end
