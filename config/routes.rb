Sledleague::Application.routes.draw do

  devise_for :users

  resources :leagues do
  	member do
  		get 'join'
  		get 'leave'
  	end
    resources :invitations do
      get 'accept/:token' => 'invitations#accept', :as => :accept
    end
  end

  resources :races do 
    resources :results
  end

  resources :athletes
  resources :matches do
    resources :predictions
  end
  resources :memberships
  resources :ajax

  get "pages/home"
  get "pages/about"
  root :to => 'pages#home'
end
