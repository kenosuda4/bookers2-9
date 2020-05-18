Rails.application.routes.draw do

  root 'homes#top'
  devise_for :users
  resources :users, only:[:index, :show, :edit, :update, :index]
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
  end


  get 'home/about', to: 'homes#about'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
