class AuthorisationsController < ApplicationController
  include OAuth2::Provider::Rack::AuthorizationCodesSupport

  before_filter :authenticate_user!
  before_filter :block_invalid_authorization_code_requests

  def new
    @client ||= OAuth2::Provider.client_class.from_param(params['client_id'])
    existing_authorisations = OAuth2::Provider::Models::ActiveRecord::Authorization.allowing(@client, current_user, nil)

    if existing_authorisations.any?
      grant_authorization_code(current_user)
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
