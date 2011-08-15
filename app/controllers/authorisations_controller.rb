class AuthorisationsController < ApplicationController
  include OAuth2::Provider::Rack::AuthorizationCodesSupport

  before_filter :authenticate_user!
  before_filter :block_invalid_authorization_code_requests

  def new
    existing_authorisations = client.authorizations.where(:resource_owner => current_user, :scope => params['scope']).where('expires_at > ?', DateTime.now)
    if existing_authorisations.any?
      throw_response Responses.redirect_with_code(existing_authorisations.first.code, redirect_uri)
    else
      @client = oauth2_authorization_request.client
    end
  end

  def create
    if params[:commit] == "Yes"
      grant_authorization_code(current_user)
    else
      deny_authorization_code
    end
  end
end
