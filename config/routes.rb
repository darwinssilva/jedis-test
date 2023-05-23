Rails.application.routes.draw do
  resources :municipes
  root 'municipes#index'
end
