namespace :clients do
  desc "Create a new OAuth2 client who's allowed to use us as an authoriser"
  task :create => :environment do
    require 'securerandom'
    raise "Requires name, id, and secret" unless ENV['name']
    name = ENV['name'].dup

    secret = SecureRandom.urlsafe_base64
    id = SecureRandom.uuid
    OAuth2::Provider.client_class.create! :name => name, :oauth_identifier => id, :oauth_secret => secret
    puts "Created OAuth client '#{name}'"
    puts "oauth_id:     #{id}"
    puts "oauth_secret: #{secret}"
  end
end