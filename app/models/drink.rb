class Drink < ApplicationRecord
  enum category: { beer: 0, wine: 1, nihonshu: 2, shochu: 3, cocktail: 4, etc: 5 }
  mount_uploader :drink_image, DrinkImageUploader

  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 250 }
  validates :alcohol, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :drink_image, presence: true
  validates :category, presence: true
end
