class User < ApplicationRecord
  authenticates_with_sorcery!

  # 値が空でないこと・最大100文字以下であること
  validates :name, presence: { message: "を入力してください" }, length: { maximum:100 }
  # 値が空でないこと・ユニークな値であること
  validates :email, presence: { message: "を入力してください" }, uniqueness: true
  # 最低3文字以上必要
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  # password_confirmation と一致すること
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  # 値が空でないこと（nilや空文字でない）
  validates :password_confirmation, presence: { message: "を入力してください" }, if: -> { new_record? || changes[:crypted_password] }
  # 属性の値が一意であり重複していないこと（nil は除く）
  validates :reset_password_token, uniqueness: true, allow_nil: true

  has_many :drinks, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_drinks, through: :bookmarks, source: :drink

  def own?(object)
    id == object&.user_id
  end

  # ブックマーク処理
  def bookmark(drink)
    bookmarked_drinks << drink
  end

  def unbookmark(drink)
    bookmarked_drinks.destroy(drink)
  end

  def bookmark?(drink)
    bookmarked_drinks.include?(drink)
  end

  # 管理者かどうか判定する
  def admin?
    is_admin
  end
end
