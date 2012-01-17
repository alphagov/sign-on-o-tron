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

  validate :strong_enough_password?, if: :password_required?

  def self.passphrase_entropy
    @passphrase_entropy ||= PassphraseEntropy.new
  end

  def strong_enough_password?
    unless self.class.passphrase_entropy.entropy(password) >= 20
      errors.add :password, "is not strong enough. Try adding symbols other than letters and numbers, or making it longer. You can use spaces"
    end
  end

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

  def self.send_reset_password_instructions(attributes = {})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)

    if recoverable.persisted?
      recoverable.send_reset_password_instructions
    else
      recoverable.errors.clear
    end

    recoverable
  end

  include Suspendable
end
