Rails.application.routes.draw do
  # Devise用のルーティング（ユーザー用）
  devise_for :users, controllers: {
  sessions: 'public/sessions'
}

# ゲストログイン用のルート
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # ユーザー用（public）ルーティング
    namespace :public do
      resources :places do
        resources :comments, only: [:create, :destroy]
        resources :likes, only: [:create, :destroy]
        resources :bookmarks, only: [:create, :destroy]
      end
    end

  # 管理者用（admin）ルーティング
    namespace :admin do
      resources :places, only: [:index, :show, :destroy] do
        # 投稿の承認や削除が必要な場合に追加
        # resources :approvals, only: [:update] # 例：承認用
      end
      resources :users, only: [:index, :show] do
        member do
          patch :freeze  # ユーザーの凍結
        end
      end
    end

  # トップページのルーティング
  root 'public/homes#top'  # トップページは施設・公園一覧に設定


end