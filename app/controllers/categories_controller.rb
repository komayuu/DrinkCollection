class CategoriesController < ApplicationController
  skip_before_action :require_login
  
  def show
    category_name = params[:category].to_s
    if category_name.blank?
      redirect_to root_path, alert: "カテゴリーが見つかりませんでした" and return
    end

    @drinks = Drink.where(category: category_name, is_admin: true)
  end
end
