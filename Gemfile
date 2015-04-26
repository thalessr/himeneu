source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'

group :development do
	# Use sqlite3 as the database for Active Record
	gem 'better_errors'
	gem 'rails_best_practices'
	gem 'bullet'
	gem 'rb-readline'
	gem 'mailcatcher'
	gem "binding_of_caller"
  gem 'colored'
  gem "awesome_print"
  gem 'quiet_assets'
  gem 'meta_request'
  gem 'capistrano-faster-assets'
  gem 'capistrano-rbenv'
  gem 'capistrano-rbenv-install'
end
group :assets  do
	gem 'sass-rails', '~> 4.0.3'
	gem 'uglifier', '>= 1.3.0'
	gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
    # gem 'therubyracer',  platforms: :ruby
end

gem 'therubyracer'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc


# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'devise'
gem "devise-async"
gem 'cancancan', '~> 1.9.2'

group :production do
  gem 'pg'
  # gem 'rails_12factor'
  gem 'passenger'
end

group :test do
	gem 'selenium-webdriver'
  gem 'mocha'
  gem 'database_cleaner'
  gem 'faker'
  gem 'minitest'
  gem 'email_spec'
  gem 'vcr'
  gem 'shoulda-matchers', require: false
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'guard'
  gem 'guard-rspec'
  gem 'sqlite3'
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'dotenv-rails'
  gem 'byebug'
  gem 'capybara'
  gem 'spring'
  gem 'spring-commands-rspec'
end

gem 'bootstrap3-datetimepicker-rails'
gem 'autosize-rails'
gem 'momentjs-rails'
gem 'carrierwave'
gem 'carrierwave_backgrounder'
gem 'mini_magick'
gem 'fog', require: "fog/aws/storage"
gem 'sidekiq'
gem 'sinatra'
gem 'redis'
gem 'redis-rails'
#Active Admin
gem 'activeadmin', github: 'activeadmin'
# gem 'inherited_resources', github: 'josevalim/inherited_resources', branch: 'rails-4-2'

gem 'geocoder'

gem 'acts-as-taggable-on', '~> 3.4'

gem 'ng-rails-csrf'

gem 'friendly_id', '~> 5.1.0'


# Use unicorn as the app server
#gem 'unicorn', '~> 4.8.3'

# Use Capistrano for deployment
gem 'capistrano-rails'
gem 'capistrano-passenger', '~> 0.0.5'
gem 'capistrano-bundler'

gem "sass_rails_patch"
gem "will_paginate"
gem "sitemap_generator"

gem 'state_machine'
gem 'whenever', :require => false
gem 'newrelic_rpm'
# Use debugger
# gem 'debugger', group: [:development, :test]

