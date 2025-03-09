class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create google_auth]

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

  def google_auth
    auth = request.env["omniauth.auth"]
    user = User.find_or_create_from_google(auth)
    user.password_confirmation = user.password #パスワード確認を自動的に設定

    if user
      auto_login(user)
      redirect_to root_path, success: "Googleでログインしました"
    else
      redirect_to new_user_session_path, danger: "Googleログインに失敗しました"
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other, success: "ログアウトしました"
  end
end
