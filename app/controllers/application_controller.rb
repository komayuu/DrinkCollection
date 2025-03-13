class ApplicationController < ActionController::Base
  before_action :require_login, :set_search
  add_flash_types :success, :danger

  helper :all

  private

  def not_authenticated
    redirect_to login_path, danger: "ログインしてください"
  end

  def set_search
    @q = Drink.ransack(params[:q])
  end
end
