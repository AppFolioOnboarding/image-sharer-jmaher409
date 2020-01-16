Rails.application.routes.draw do
  # question: should we keep this route?
  get 'welcome/index'

  resources :images, only: %i[new create show index]
  root 'images#index'
end
