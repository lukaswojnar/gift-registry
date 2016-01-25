Rails.application.routes.draw do
  root 'welcome#index'

  get 'lists/buy', to: 'lists#buy'

  resources :lists do
    resources :gifts
  end

  post '/' => 'welcome#search'
  get 'search/:id', to: 'gifts#search'
  post 'search/:id', to: 'gifts#assign'

  devise_for :users#, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
end
