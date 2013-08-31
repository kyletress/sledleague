Sledleague::Application.routes.draw do

  devise_for :users
  resources :leagues
  resources :races

  get "pages/home"
  get "pages/about"
  root :to => 'pages#home'
end
