Sledleague::Application.routes.draw do
  devise_for :users

  get "pages/home"
  get "pages/about"
  root :to => 'pages#home'
end
