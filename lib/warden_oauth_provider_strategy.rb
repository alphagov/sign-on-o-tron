require 'warden/strategies/base'

class WardenOAuthProviderStrategy < Warden::Strategies::Base
  def valid?
    params['oauth_token']
  end

  def authenticate!
    u = request.env['oauth2'].resource_owner
    u.nil? ? fail!("Invalid OAuth credentials") : success!(u)
  end
end
