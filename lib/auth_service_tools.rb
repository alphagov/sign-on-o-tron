require 'securerandom'

class AuthServiceTools
  attr_accessor :client, :token

  def create_client(name, id = nil, secret = nil)
    id ||= SecureRandom.uuid
    secret ||= SecureRandom.urlsafe_base64
    @client = OAuth2::Provider.client_class.create!(
      name: name, oauth_identifier: id, oauth_secret: secret
    )
  end

  def set_client_by_name(name)
    @client = OAuth2::Provider.client_class.find_by_name!(name)
  end

  def create_token(resource_owner = nil, redirect_uri = '#')
    grant = client.authorizations.create!(
      resource_owner: resource_owner,
      client: client
    )
    code = grant.authorization_codes.create!(redirect_uri: redirect_uri)
    @token = client.authorization_codes.claim(code.code, code.redirect_uri)
    @token.expires_at = 10.years.from_now
    @token.save!
  end

  def description
    output = []
    output << "Created OAuth client '#{client.name}'"
    output << "  oauth_id = '#{client.oauth_identifier}'"
    output << "  oauth_secret = '#{client.oauth_secret}'"

    if @token
      output << "  access_token = '#{@token.access_token}'"
      output << "  refresh_token = '#{@token.refresh_token}'"
      output << "  # expires '#{@token.expires_at}'"
    end
    
    output << ""
    output.join "\n"
  end
end