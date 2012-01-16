Signonotron::Application.routes.draw do
  devise_for :users, controllers: { passwords: 'passwords' }

  match '/oauth/authorize', :via => :get, :to => 'authorisations#new'
  match '/oauth/authorize', :via => :post, :to => 'authorisations#create'

  match '/logout', :via => :get,    :to => 'sessions#logout'
  match '/logout', :via => :delete, :to => 'sessions#destroy'

  resource :user, :except => [:destroy, :new]

  root :to => 'root#index'
end
