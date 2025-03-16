class DrinksController < ApplicationController
  before_action :set_drink, only: %i[show edit update destroy]

  def index
    @q = Drink.ransack(params[:q])
    @drinks = @q.result(distinct: true)
    search_keyword = params.dig(:q, :name_or_description_or_mixing_instructions_cont)
    category_id = params.dig(:q, :category_id_eq) # 選択されたカテゴリーID
    category_name = category_id.present? ? Category.find_by(id: category_id)&.name : nil
    if search_keyword.present?
      @rakuten_items = RakutenApi.search_items(search_keyword, category_name)
    else
      @rakuten_items = []
    end
  end
  
  def show
    @drink = Drink.find(params[:id])
    @bookmarked_drinks = current_user.bookmarked_drinks || []
  end

  # 編集フォームを表示
  def edit
    @drink # @drinkはbefore_actionで設定されたdrinks
  end

  # 更新処理
  def update
    if @drink.update(drink_params)
      redirect_to @drink, success: 'ドリンク情報が更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # 削除処理
  def destroy
    @drink.destroy
    redirect_to drinks_url, success: 'ドリンクが削除されました。'
  end

  # ブックマーク
  def bookmarks
    @bookmark_drinks = current_user.bookmarked_drinks.includes(:user).order(created_at: :desc)
  end

  private

  def set_drink
    @drink = Drink.find(params[:id])
  end

  def drink_params
    params.require(:drink).permit(:name, :description, :alcohol, :mixing_instructions, :image)
  end
end
