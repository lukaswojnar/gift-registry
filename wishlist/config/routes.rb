Rails.application.routes.draw do
  root 'welcome#index'

  resources :lists do
    resources :gifts
    resources :invitations
  end

  post '/invitations/create' => 'invitations#create'
  get '/my-invitations' => 'invitations#my_invivations'

  devise_for :users#, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
end
