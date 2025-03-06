class BookmarksController < ApplicationController

  # ブックマークを作成
  def create
    drink = Drink.find(params[:drink_id])
    current_user.bookmark(drink)
    redirect_to drinks_path, success: "ブックマークしました"
  end

  # ブックマークを削除
  def destroy
    drink = current_user.bookmarks.find(params[:id]).drink
    current_user.unbookmark(drink)
    redirect_to drinks_path, success: "ブックマークを解除しました", status: :see_other
  end
end
