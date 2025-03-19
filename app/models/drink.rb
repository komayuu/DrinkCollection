class Drink < ApplicationRecord
  mount_uploader :drink_image, DrinkImageUploader

  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 250 }
  validates :alcohol, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :drink_image, presence: true
  validates :category_id, presence: true

  belongs_to :user
  belongs_to :category
  has_many :bookmarks, dependent: :destroy

  ransack_alias :alcohol_eq, :alcohol
  ransack_alias :category_id_eq, :category_id

  # 日本語表示用のヘルパーを追加
  def category_name
    category&.name || '不明'
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "description", "alcohol", "category_id", "created_at", "updated_at", "user_id", "mixing_instructions", "drink_image"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end
end
