Rails.application.routes.draw do
  root 'welcome#index'

  resources :lists do
    resources :gifts
    resources :invitations
  end

  post '/invitations/create' => 'invitations#create'
  get '/my-invitations' => 'invitations#my_invitations'
  get '/accept-invitation/:invitation_id' => 'invitations#accept_invitation', :as => :accept_invitation
  get '/decline-invitation/:invitation_id' => 'invitations#decline_invitation', :as => :decline_invitation

  get '/lists/:id/detail' => 'lists#detail'
  get '/take-gift/:id' => 'gifts#take_gift', :as => :take_gift

  devise_for :users#, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
end
