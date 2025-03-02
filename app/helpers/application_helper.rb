module ApplicationHelper
  # カテゴリーごとのパスを定義
  def category_path(category)
    category.present? ? category_url(category) : categories_path
  end
end
