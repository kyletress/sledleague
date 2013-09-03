Sledleague::Application.routes.draw do

  get "memberships/new"


  devise_for :users

  resources :leagues do
  	member do
  		get 'join'
  		get 'leave'
  	end
    resources :invitations do
      get 'accept/:token' => 'invitations#accept'
    end
  end
  resources :races do
  	resources :results
  end

  resources :athletes
  resources :matches
  resources :predictions
  resources :memberships

  get "pages/home"
  get "pages/about"
  root :to => 'pages#home'
end
