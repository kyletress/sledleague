Sledleague::Application.routes.draw do

  devise_for :users
  resources :leagues do
  	member do
  		get 'join'
  		get 'leave'
  	end
  end
  resources :races

  get "pages/home"
  get "pages/about"
  root :to => 'pages#home'
end
