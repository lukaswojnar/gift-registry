Rails.application.routes.draw do
  root 'welcome#index'
  resources :gift

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
end
