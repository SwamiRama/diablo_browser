Rails.application.routes.draw do
  devise_for :users

  root 'diablo#index'

  get 'diablo/search'

  get 'users', to: 'users#show'

  get 'careers', to: 'careers#show'

  get 'heros', to: 'heroes#show'
end
