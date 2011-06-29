require 'oauth2_filter'

class ApplicationController < ActionController::Base
  include OAuth2Filter

  protect_from_forgery
end

