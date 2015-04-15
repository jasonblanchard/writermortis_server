source 'https://rubygems.org'

ruby "2.2.1"

gem 'rails', '4.2.1'

gem 'rails-api'

group :development do
  gem 'spring'
  gem "bullet"
end

group :production do
  gem 'pg'
end

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', :group => :development

group :test, :development do
  gem 'rspec-rails', '~> 3.0.0'
  gem "factory_girl_rails", "~> 4.0", :require => false
  gem "shoulda-context", "~> 1.2"
  gem "shoulda-matchers"
  gem 'capybara'
  gem 'database_cleaner'
  gem "byebug"
  gem 'sqlite3'
end

group :test do
  gem 'simplecov', :require => false
end

gem 'redis'
gem 'devise'

gem "active_model_serializers", "~> 0.8.0"

gem "pundit"

gem 'rails_12factor', group: :production
