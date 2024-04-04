Rails.application.routes.draw do
  resources :categories do
    collection do#display_updateメソッドは一括でcategoriesを更新するためcollectionでルーティングを指定している
      patch :display_update
    end
  end

  resources :orders do
    collection do
      get :unchecked_index
      get :checked_index
    end
  end

  devise_for :admins
  root 'hello_vue#index'
  get 'hello_vue/index'
  
  
  #letter_openerを使用するためのルーティング
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
