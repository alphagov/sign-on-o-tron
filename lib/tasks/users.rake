namespace :users do
  desc "Create a new user"
  task :create => :environment do
    require 'securerandom'
    raise "Requires name and email" unless ENV['name'] && ENV['email']
    default_password = SecureRandom.urlsafe_base64
    user_params = {
      :name => ENV['name'],
      :email => ENV['email'],
      :github => (ENV['github'] || nil),
      :twitter => (ENV['twitter'] || nil),
      :password => "#{default_password}",
      :password_confirmation => "#{default_password}",
      :uid => SecureRandom.urlsafe_base64
    }

    params = Hash[user_params.reject { |k, v| v.nil? }.collect { |k, v| [k, v.dup] }]
    user = User.create(params)
    user.send_reset_password_instructions
    puts "User created: user.name <#{user.email}>"
  end
end