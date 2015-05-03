ruby '2.2.2'
source 'https://rubygems.org'
source 'https://rails-assets.org' do
  gem 'rails-assets-angular', '~> 1.3'
  group :development, :test do
    gem 'rails-assets-angular-mocks', '~> 1.3'
  end
end

gem 'rails', '4.2'
gem 'rake', '~> 10'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'coffee-rails', '~> 4.1'
gem 'haml', '~> 4.0'
gem 'jquery-rails'
gem 'bootstrap-sass', '~> 3.3' # previously 3.0.1.0.rc

gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
gem 'turbolinks', '~> 2.5'
gem 'jbuilder', '~> 1.2'
gem 'json', '~> 1.8.2' # Version 1.8.0 broken with Ruby 2.2 see https://github.com/flori/json/issues/229
gem 'responders', '~> 2.0'

gem 'interactor', '~> 3.1'
gem 'draper', '~> 1.3'
gem 'devise', '~> 3.4'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  gem 'guard', '~> 2.12'
  gem 'guard-rspec', '~> 4.5', require: false
  gem 'web-console', '~> 2.0'
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

group :production do
  gem 'newrelic_rpm', '~> 3.11'
end