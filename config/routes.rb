Rails.application.routes.draw do
  devise_for :admins
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
      collection do#display_updateメソッドは一括でcategoriesを更新するためcollectionでルーティングを指定している
        patch :display_update
      end
    end
    resources :orders do
      resources :show_pdf, only: :index
      collection do
        get :unchecked_index
        get :checked_index
        get :complete
        get 'search' => 'orders#unchecked_index'
        get 'search' => 'orders#checked_index'
      end
    end
  end
  
  #letter_openerを使用するためのルーティング
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end