Rails.application.routes.draw do
  root "static_pages#top"
  # ユーザー処理
  resources :users, only: %i[new create show edit update]
  # 投稿一覧、投稿作成
  resources :posts, only: %i[index new create show edit update destroy]
  # ログインアウト処理
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
  delete "/logout", to: "user_sessions#destroy"
end
