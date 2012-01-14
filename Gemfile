source 'http://rubygems.org'

group :passenger_compatibility do
  gem 'rack', '1.3.5'
  gem 'rake', '0.9.2'
end

gem 'rails', '~> 3.1.3'
gem 'plek'

gem 'mysql2', '~> 0.3.0'
gem 'devise', '~> 1.5.3'
gem 'oauth2-provider', :git => 'git://github.com/alphagov/oauth2-provider.git'
gem 'formtastic', '~> 1.2.4'
gem 'aws-ses', :require => 'aws/ses'
gem 'exception_notification'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'rspec-rails', '~> 2.6.0'
  gem 'sqlite3-ruby', :require => 'sqlite3'
 end

group :test do
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'simplecov', '0.4.2'
  gem 'simplecov-rcov'
  gem 'ci_reporter'
  gem 'launchy'
end
