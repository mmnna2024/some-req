Rails.application.routes.draw do
  devise_for :admins
  root 'hello_vue#index'
  get 'hello_vue/index'
  
  
  #letter_openerを使用するためのルーティング
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
