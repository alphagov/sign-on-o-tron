lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'auth_service_tools'

namespace :clients do
  desc "Create a new OAuth2 client (options: name, [id], [secret])"
  task :create => :environment do
    raise "Requires name. id and secret are optional" unless ENV['name']
    
    @service ||= AuthServiceTools.new
    @service.create_client(ENV['name'], ENV['id'], ENV['secret'])

    puts @service.description
  end
  
  desc "Create access token for an existing OAuth2 client (options: name, [id], [secret])"
  task :create_access_token => :environment do
    raise "Requires name. id and secret are optional" unless ENV['name']

    @service ||= AuthServiceTools.new
    @service.set_client_by_name(ENV['name'])
    @service.create_token

    puts @service.description
  end

  desc "Create an OAuth2 client and create access token (options: name, [id], [secret])"
  task :setup_access => :environment do
    raise "Requires name. id and secret are optional" unless ENV['name']

    @service ||= AuthServiceTools.new
    @service.create_client(ENV['name'], ENV['id'], ENV['secret'])
    @service.create_token

    puts @service.description
  end
  
end