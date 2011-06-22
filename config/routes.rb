require 'extra_config'

Halberd::Application.routes.draw do
  devise_for :users

  match '/oauth/authorize', :via => :get, :to => 'authorisations#new'
  match '/oauth/authorize', :via => :post, :to => 'authorisations#create'

  resource :user, :only => [:show]

  root :to => 'root#index'
end
