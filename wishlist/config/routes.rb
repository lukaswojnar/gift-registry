Rails.application.routes.draw do
  root 'welcome#index'

  resources :lists do
    resources :gifts
    resources :invitations
  end

  resources :notifications

  post '/invitations/create' => 'invitations#create'
  get '/my-invitations' => 'invitations#my_invitations'
  get '/accept-invitation-on-event/:invitation_id' => 'invitations#accept_invitation_on_event', :as => :accept_invitation_on_event
  get '/decline-invitation-on-event/:invitation_id' => 'invitations#decline_invitation_on_event', :as => :decline_invitation_on_event

  get '/lists/:id/detail' => 'lists#detail', :as => :list_detail
  get '/gifts_to_buy' => 'gifts#gifts_to_buy', :as => :gifts_to_buy
  get '/take-gift/:id' => 'gifts#take_gift', :as => :take_gift
  get '/remove-assigned-gift/:id' => 'gifts#remove_assigned_gift', :as => :remove_assigned_gift

  devise_for :users#, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}

  # routes for notifications
  post '/notifications/create' => 'notifications#create'
  get '/my-notifications' => 'notifications#index'
  get '/notifications/create/:list_id' => 'notifications#new', :as => :create_notification

end
