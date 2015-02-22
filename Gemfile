source 'https://rubygems.org'


gem 'rails', '4.1.1'

gem 'rails-api'

group :development do
  gem 'spring'
  gem "bullet"
end

gem 'sqlite3'

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
end

group :test do
  gem 'simplecov', :require => false
end

gem 'debugger', :group => :development
gem 'redis'
gem 'devise'

gem "active_model_serializers", "~> 0.8.0"

gem "pundit"
gem "redis"
