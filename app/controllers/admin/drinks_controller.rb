module Admin
  class Admin::DrinksController < ApplicationController
    before_action :require_admin

    def post_index
      @drinks = Drink.all
    end

    def new
      @drinks = Drink.new
    end

    def create
      @drink = Drink.new(drink_params)
      if @drink.save
        redirect_to admin_drinks_path, notice: "新しいドリンクが追加されました。"
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def drink_params
      params.require(:drink).permit(:name, description, float, drink_image, drink_type, mixing_instructions, :category)
    end

    def require_admin
      unless current_user&.admin?
        redirect_to root_path, alert: "管理者のみアクセス可能です。"
      end
    end
  end
end
