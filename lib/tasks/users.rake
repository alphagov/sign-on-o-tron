require 'securerandom'

namespace :users do
  desc "Create a new user"
  task :create => :environment do
    raise "Requires name and email" unless ENV['name'] && ENV['email']
    default_password = SecureRandom.urlsafe_base64
    user_params = {
      :name => ENV['name'],
      :email => ENV['email'],
      :github => (ENV['github'] || nil),
      :twitter => (ENV['twitter'] || nil),
      :password => "#{default_password}",
      :password_confirmation => "#{default_password}"
    }

    params = Hash[user_params.reject { |k, v| v.nil? }.collect { |k, v| [k, v.dup] }]
    puts params.inspect
    user = User.create(params)
    puts user.inspect
    puts "password: #{default_password}"
    user.send_reset_password_instructions
  end
end