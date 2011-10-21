require 'warden/strategies/base'

class WardenOAuthProviderStrategy < Warden::Strategies::Base
  def token
    token_from_param || token_from_header
  end

  def token_from_param
    params["oauth_token"]
  end

  def token_from_header
    if authorization_header.provided?
      authorization_header.params
    end
  end

  def authorization_header
    @authorization_header ||= Rack::Auth::AbstractRequest.new(env)
  end

  def valid?
    token.present?
  end

  def authenticate!
    u = request.env['oauth2'].resource_owner
    u.nil? ? fail!("Invalid OAuth credentials") : success!(u)
  end
end
