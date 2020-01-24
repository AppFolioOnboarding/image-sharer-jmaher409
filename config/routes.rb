Rails.application.routes.draw do
  resources :images, only: %i[new create show index destroy]
  root 'images#index'
end
