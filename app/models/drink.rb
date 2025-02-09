class Drink < ApplicationRecord
  belongs_to :user
  enum category: { beer: 0, wine: 1, nihonshu: 2, shochu: 3, cocktail: 4, etc: 5 }

  validates :name, presence: true
  validates :description, presence: true
  validates :alcohol, presence: true
  validates :drink_image, presence: true
  validates :drink_type, presence: true
  validates :category, presence: true
end
