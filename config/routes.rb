require 'extra_config'

Halberd::Application.routes.draw do
  devise_for :users, :pepper => ExtraConfig::DEVISE_PEPPER

  root :to => 'root#index'
end
