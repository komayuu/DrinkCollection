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
  # Googleログインの場合はpasswordを仮に設定する（パスワードのバリデーションをスキップ）
  validates :password, presence: true, if: -> { new_record? && crypted_password.blank? }
  validates :password_confirmation, presence: true, if: -> { password.present? }
  # 属性の値が一意であり重複していないこと（nil は除く）
  validates :reset_password_token, uniqueness: true, allow_nil: true
  # Googleログイン用
  validates :google_uid, uniqueness: true, allow_nil: true

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

  # Googleログイン時のユーザー検索または作成
  def self.find_or_create_from_google(auth)
    user = find_by(google_uid: auth["uid"])

    unless user
      user = find_by(email: auth["info"]["email"])
      if user
        user.update(google_uid: auth["uid"])
      else
        user = User.new(
          name: auth["info"]["name"],
          email: auth["info"]["email"],
          google_uid: auth["uid"],
          password: SecureRandom.hex(10)
        )
        user.password_confirmation = user.password
        user.save(validate: false)
      end
    end

    user
  end
end
