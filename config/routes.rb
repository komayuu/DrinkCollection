Rails.application.routes.draw do
  root "static_pages#top"
  # ユーザー処理
  resources :users, only: %i[new create show edit update]
  resource :mypage, only: %i[show edit update]
  # 投稿一覧、投稿作成
  resources :posts, only: %i[index new create show edit update destroy]
  # カテゴリーページ
  resources :categories, only: %i[show], param: :category
  resources :drinks, only: %i[show]
  # ログインアウト処理
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
  delete "/logout", to: "user_sessions#destroy"
  # Google認証
  get "/auth/:provider/callback", to: "user_sessions#google_auth"
  get "/auth/failure", to: redirect("/")
  # 管理者専用ページ設定
  namespace :admin do
    resources :drinks, only: %i[index new create]
  end
  # Drinkのブックマーク設定
  resources :bookmarks, only: %i[create destroy]
  resources :drinks, only: %i[index new create show edit update destroy] do
    collection do
      get :bookmarks
    end
  end
  # 利用規約、プライバシーポリシー
  get "pages/privacy_policy", to: "pages#privacy_policy", as: "privacy_policy"
  get "pages/terms_of_service", to: "pages#terms_of_service", as: "terms_of_service"
end
