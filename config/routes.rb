Rails.application.routes.draw do
  get 'welcome/index'

  resources :images
  root 'images#index'
end
