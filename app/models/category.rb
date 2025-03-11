class Category < ApplicationRecord
  has_many :posts
  has_many :drinks

  ransack_alias :name_cont, :name
end
