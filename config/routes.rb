Rails.application.routes.draw do
  root "static_pages#top"
  # ユーザー処理
  resources :users, only: %i[new create show edit update]
  # 投稿一覧、投稿作成
  resources :posts, only: %i[index new create show edit update destroy]
  # カテゴリーページ
  get "categories/beer", to: "categories#beer"
  get "categories/wine", to: "categories#wine"
  get "categories/nihonshu", to: "categories#nihonshu"
  get "categories/shochu", to: "categories#shochu"
  get "categories/cocktail", to: "categories#cocktail"
  get "categories/etc", to: "categories#etc"
  get "categories/:category", to: "categories#show", as: "category"
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
