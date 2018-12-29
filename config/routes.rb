Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  resources :users, only: [:index, :show, :new, :create]
    
  resources :microposts, only: [:create, :destroy]

    # member do #idがいる時
    #   get 'extendshow'
    # end
    
    # collection do #idがいらない
    #   get 'edit'
    #   patch 'update'
    #   put   'update'
    #   delete 'destroy'
      
    
end

