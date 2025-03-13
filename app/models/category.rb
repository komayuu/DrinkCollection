class Category < ApplicationRecord
  has_many :posts
  has_many :drinks

  ransack_alias :name_cont, :name

  def display_name
    translations = {
      "beer" => "ビール",
      "wine" => "ワイン",
      "nihonshu" => "日本酒",
      "shochu" => "焼酎",
      "cocktail" => "カクテル",
      "etc" => "その他"
    }
    translations[name] || name # 該当する名前がない場合はそのまま返す
  end
end
