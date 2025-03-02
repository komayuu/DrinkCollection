class MypagesController < ApplicationController
  before_action :require_login

  def show
    @user = current_user
    @posts = @user.posts.order(created_at: :desc) # ユーザーの投稿一覧
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypage_path, notice: 'プロフィールを更新しました'
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
