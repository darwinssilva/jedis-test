Rails.application.routes.draw do
  resources :municipes do
    resource :endereco, only: [:new, :create, :edit, :update]
  end

  root 'municipes#index'
end
