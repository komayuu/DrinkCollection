module Admin
  class Admin::DrinksController < ApplicationController
    before_action :require_admin

    def new
      @drink = Drink.new
    end

    def create
      @drink = current_user.drinks.new(drink_params)
      @drink.is_admin = true

      category = Category.find_by(name: params[:drink][:category])
      @drink.category = category if category.present?
      @drink.category_id = category.id if category.present?

      if @drink.save
        redirect_to admin_drinks_path, success: "新しいドリンクが追加されました。"
      else
        flash.now[:alert] = @drink.errors.full_messages.join(", ")
        render :new, status: :unprocessable_entity
      end
    end

    private

    def drink_params
      params.require(:drink).permit(:name, :description, :alcohol, :drink_image, :mixing_instructions, :category_id, :drink_image).tap do |whitelisted|
        # カテゴリー名をカテゴリーIDに変換
        if params[:drink][:category].present?
          category = Category.find_by(name: params[:drink][:category])
          whitelisted[:category_id] = category.id if category.present?
        end
      end
    end

    def require_admin
      unless current_user&.is_admin?
        redirect_to root_path, alert: "管理者のみアクセス可能です。"
      end
    end
  end
end
