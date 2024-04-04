Rails.application.routes.draw do
  get 'orders/new'
  resources :categories do
    collection do#display_updateメソッドは一括でcategoriesを更新するためcollectionでルーティングを指定している
      patch :display_update
    end
  end

  devise_for :admins
  root 'hello_vue#index'
  get 'hello_vue/index'
  resources :orders
  
  #letter_openerを使用するためのルーティング
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end