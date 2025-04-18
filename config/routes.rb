Rails.application.routes.draw do
  # 顧客用
# URL /customers/sign_in ...
devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations], controllers: {
  sessions: "admin/sessions"
}

# ゲストログイン用
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # ユーザー用（public）ルーティング
  namespace :public do
    resources :users, only: [:show, :edit, :update] do
      patch :withdraw, on: :member  # 退会処理
    end

    resources :bookmarks, only: [:index, :create, :destroy]

  
    resources :places do
      resources :comments, only: [:create, :destroy]
      resources :likes, only: [:create, :destroy]
    end
  end

  # 管理者用（admin）ルーティング
    namespace :admin do
      resources :places, only: [:index, :show, :edit, :update, :destroy]
      resources :users, only: [:index, :show, :edit, :update]
      resources :comments, only: [:index, :destroy]  # ← ここが修正ポイント！
    end

  # トップページのルーティング
  root 'public/homes#top'  # トップページは施設・公園一覧に設定


end