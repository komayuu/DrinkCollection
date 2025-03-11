class Drink < ApplicationRecord
  enum category: { beer: 0, wine: 1, nihonshu: 2, shochu: 3, cocktail: 4, etc: 5 }, _prefix: true
  mount_uploader :drink_image, DrinkImageUploader

  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 250 }
  validates :alcohol, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :drink_image, presence: true
  validates :category, presence: true

  belongs_to :user
  has_many :bookmarks, dependent: :destroy

  ransack_alias :alcohol_eq, :alcohol
  ransack_alias :category_id_eq, :category_id

  scope :alcohol_range, ->(range) {
    case range
    when "0"
      where(alcohol: 0)
    when "1-10"
      where("alcohol >= 1 AND alcohol <= 10")
    when "11-20"
      where("alcohol >= 11 AND alcohol <= 20")
    when "21-30"
      where("alcohol >= 21 AND alcohol <= 30")
    when "31-40"
      where("alcohol >= 31 AND alcohol <= 40")
    when "41-50"
      where("alcohol >= 41 AND alcohol <= 50")
    when "51-60"
      where("alcohol >= 51 AND alcohol <= 60")
    when "61-70"
      where("alcohol >= 61 AND alcohol <= 70")
    when "71-80"
      where("alcohol >= 71 AND alcohol <= 80")
    when "81-90"
      where("alcohol >= 81 AND alcohol <= 90")
    when "91-100"
      where("alcohol >= 91 AND alcohol <= 100")
    end
  }

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "description", "alcohol", "category", "category_id", "created_at", "updated_at", "user_id", "mixing_instructions", "drink_image"]
  end
end
