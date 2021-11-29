Rails.application.routes.draw do
  devise_for :admins
  
  #resources :posts
    resources :posts, only: %i[index show edit destroy new create] do
    resources :comments, only: [:create]
  end
  root 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
