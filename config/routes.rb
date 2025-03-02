Rails.application.routes.draw do
  root "static_pages#top"
  # ユーザー処理
  resources :users, only: %i[new create show edit update]
  resource :mypage, only: %i[show edit update]
  # 投稿一覧、投稿作成
  resources :posts, only: %i[index new create show edit update destroy]
  # カテゴリーページ
  resources :categories, only: [:show], param: :category
  # ログインアウト処理
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
  delete "/logout", to: "user_sessions#destroy"
  # 管理者専用ページ設定
  namespace :admin do
    resources :drinks, only: [:index, :new, :create]
  end
end
