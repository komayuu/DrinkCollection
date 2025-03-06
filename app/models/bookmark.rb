class Bookmark < ApplicationRecord
  validates :user_id, uniqueness: { scope: :drink_id }

  belongs_to :user
  belongs_to :drink
end
