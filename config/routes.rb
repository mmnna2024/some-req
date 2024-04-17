Rails.application.routes.draw do
  devise_for :admins, {
    path: 'admin',
  }
  root 'hello_vue#index'
  get 'hello_vue/index'
  get 'orders/new'

  resources :orders, only: [:new, :create, :edit] do
    collection do
      get :complete
    end
  end

  namespace :admin do
    resources :categories do
      member do
        put :display_update
      end
    end
    resources :orders do
      resources :show_pdf, only: :index
      collection do
        get :unchecked_index
        get :checked_index
        get :complete
        get 'unchecked_search' => 'orders#unchecked_index'
        get 'checked_search' => 'orders#checked_index'
      end
    end
  end
  
  #letter_openerを使用するためのルーティング
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end