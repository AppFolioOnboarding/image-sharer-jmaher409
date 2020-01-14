Rails.application.routes.draw do
  get 'welcome/index'

  resources :images
  root 'welcome#index'
end
