Rails.application.routes.draw do
  root 'welcome#index'

  resources :lists do
    resources :gifts
  end

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
end
