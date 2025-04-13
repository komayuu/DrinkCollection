module Admin
  class Admin::DrinksController < ApplicationController
    before_action :require_admin
    before_action :set_categories, only: [:new, :create, :edit]
    skip_before_action :require_login, only: %i[index]

    def new
      @drink = Drink.new
    end

    def index
      @drinks = Drink.all.page(params[:page]).per(20)
      render "drinks/index"
    end

    def create
      @drink = current_user.drinks.new(drink_params)
      @drink.is_admin = true

      category = Category.find_by(id: params[:drink][:category_id])
      @drink.category = category if category.present?

      if @drink.save
        redirect_to category_path(@drink.category.name), success: "新しいドリンクが追加されました。"
      else
        flash.now[:alert] = @drink.errors.full_messages.join(", ")
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @drink = Drink.find(params[:id])
    end

    def update
      @drink = Drink.find(params[:id])
      
      if @drink.update(drink_params)
        redirect_to admin_drinks_path, success: "ドリンク情報が更新されました。"
      else
        flash.now[:alert] = @drink.errors.full_messages.join(", ")
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_categories
      @categories = Category.all
    end

    def drink_params
      params.require(:drink).permit(:name, :description, :alcohol, :drink_image, :mixing_instructions, :category_id)
    end

    def require_admin
      unless current_user&.is_admin?
        redirect_to root_path, alert: "管理者のみアクセス可能です。"
      end
    end
  end
end
