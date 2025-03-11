class Drink < ApplicationRecord
  enum category: { beer: 0, wine: 1, nihonshu: 2, shochu: 3, cocktail: 4, etc: 5 }, _prefix: true
  mount_uploader :drink_image, DrinkImageUploader

  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 250 }
  validates :alcohol, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :drink_image, presence: true
  validates :category, presence: true

  belongs_to :user
  belongs_to :category
  has_many :bookmarks, dependent: :destroy

  ransack_alias :alcohol_eq, :alcohol
  ransack_alias :category_id_eq, :category_id

  # 日本語表示用のヘルパーを追加
  def category_name
    case category
    when 'beer'
      'ビール'
    when 'wine'
      'ワイン'
    when 'nihonshu'
      '日本酒'
    when 'shochu'
      '焼酎'
    when 'cocktail'
      'カクテル'
    when 'etc'
      'その他'
    else
      '不明'
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "description", "alcohol", "category", "category_id", "created_at", "updated_at", "user_id", "mixing_instructions", "drink_image"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end
end
