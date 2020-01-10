Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#home'

  get '/add_image_form', to: 'images#add_image_form'

  resources :images
end

