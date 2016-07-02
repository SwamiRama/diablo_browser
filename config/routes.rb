Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  resources :chatrooms, param: :slug
  resources :messages

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  root 'diablo#index'

  get 'diablo/search'

  get 'careers', to: 'careers#show'

  get 'heros', to: 'heroes#show'
end
