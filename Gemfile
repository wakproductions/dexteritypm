source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.0'
gem 'pg'
gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'haml', '~> 4.0'
gem 'jquery-rails'
gem 'bootstrap-sass', '~> 3.3' # previously 3.0.1.0.rc
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets

gem 'turbolinks'
gem 'jbuilder', '~> 1.2'

gem 'interactor', '~> 3.1'
gem 'draper', '~> 1.3'
gem 'devise', '~> 3.1'

gem 'newrelic_rpm', '~> 3.11'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  gem 'guard', '~> 2.12'
  gem 'guard-rspec', '~> 4.5', require: false
end

group :development, :test do
  gem 'rspec-rails',  '~> 3.2'
  #gem 'shoulda-matchers' # thinking about discontinuing Shoulda for RSpec 3
  gem 'cucumber-rails',  '~> 1.4', :require => false
  gem 'capybara', '~> 2.4'
  gem 'database_cleaner', '~> 1.4' # recommended per cucumber docs
end

group :development, :staging, :test do
  # For making mock data
  gem 'factory_girl_rails', '~> 4.5'
  gem 'forgery', '~> 0.6'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
