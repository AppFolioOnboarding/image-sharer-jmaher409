Rails.application.routes.draw do
  resources :images, only: %i[new create show index]
  root 'images#index'
end
