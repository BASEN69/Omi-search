Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  namespace :admins do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy, :index, :show]
    resources :posts, only: [:destroy, :show]
    resources :post_comments, only: [:destroy, :index]
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
  end

  scope module: :public do

    devise_for :users
    devise_scope :user do
      post "sessions/guest_sign_in", to: "sessions#guest_sign_in"
    end
    root to: 'homes#top'
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy, :edit, :update]
      resource :favorites, only: [:create, :destroy] 
      #userの特定に関してはpostmodelで行っているため、いいねにidを持たせなくていいためresourceを使用
    end
    get '/mypage', to: 'users#my_page', as: 'mypage'
    resources :users, only: [:show, :edit, :update, :index, :destroy] do
      member do
        get :favorites
        #どのユーザーか判別するためにはidが必要なのでmemberを用いる
      end
    end
    get '/about' => 'homes#about', as: 'about'
    resources :genres, only: [:index, :show]
    get '/search', to: 'searches#search'
    get 'tagsearches/search', to: 'tagsearches#search'

    resources :maps, only: [:index, :show]

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
