Rails.application.routes.draw do
  root 'books#index'
  resources :books
  resources :authors
  resources :carts

  resources :carts do
    member do
      post :add
    end
  end

  resources :carts do
    member do
      post :remove_one
    end
  end


  resources :carts do
    member do
      post :remove_item
    end
  end

  get '/my_cart', to: 'carts#index'

  resources :users do 
    member do
      post :block
    end
  end

  resources :users do 
    member do
      post :unblock
    end
  end
  get '/sign_up', to: 'users#new'
  post '/sign_up', to: 'users#create'

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'


end
