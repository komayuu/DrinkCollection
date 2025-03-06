class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create callback]

  def new; end

  def create
    @user = login(params[:email], params[:password], params[:remember_me])

    if @user
      remember_me! if params[:remember_me] == "1" # チェックボックスがオンの時remember_meを有効化
      redirect_to root_path, success: "ログインしました"
    else
      flash.now[:danger] = "ログインに失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other, success: "ログアウトしました"
  end

  def callback
    user = login_from(:google)

    if user
      remenber_me! if params[:remember_me] == "1"
      redirect_to root_path, success: "Googleアカウントでログインしました"
    else
      redirect_to login_path, danger: "Googleログインに失敗しました"
    end
  end
end
