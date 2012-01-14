require 'digest/md5'
require 'rack/utils'
require "digest"

class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :trackable,
    :validatable, :timeoutable, :lockable
  
  attr_accessible :uid, :name, :email, :password, :password_confirmation,
    :twitter, :github, :beard
  attr_readonly :uid

  has_many :authorisations, as: :resource_owner,
    class_name: "OAuth2::Provider::Models::ActiveRecord::Authorization"

  validates_format_of :password, with: /[!@#\$%^&*?_~-].*?[!@#\$%^&*?_~-]/,
    message: 'must contain symbols other than numbers and letters'

  def gravatar_url(opts = {})
    opts.symbolize_keys!
    qs = opts.select { |k, v| k == :s }.collect { |k, v| "#{k}=#{Rack::Utils.escape(v)}" }.join("&")
    qs = "?" + qs unless qs == ""
    scheme_and_host = opts[:ssl] ? "https://secure.gravatar.com" : "http://www.gravatar.com"
    "#{scheme_and_host}/avatar/#{Digest::MD5.hexdigest(email.downcase)}#{qs}"
  end

  def to_sensible_json
    to_json(:only => [:uid, :version, :name, :email, :github, :twitter])
  end
end
