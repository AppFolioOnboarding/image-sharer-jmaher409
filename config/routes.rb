Rails.application.routes.draw do
  get 'welcome/index'

  resources :images, only: %i[new create show]
  root 'welcome#index'
end
