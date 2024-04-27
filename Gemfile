# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.0'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use devise and devise-jwt for user authentication
gem 'devise', '~> 4.9', '>= 4.9.4'
gem 'devise-jwt', '~> 0.11.0'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem 'rack-cors', '~> 2.0', '>= 2.0.2'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'byebug'

  gem 'database_cleaner-active_record', '~> 2.1'
  gem 'factory_bot_rails', '~> 6.4', '>= 6.4.3'
  gem 'faker', '~> 3.3.1'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
  gem 'rspec-rails', '~> 6.1', '>= 6.1.2'
  gem 'shoulda-matchers', '~> 6.2'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem 'rubocop', '~> 1.63', '>= 1.63.3', require: false
  gem 'rubocop-factory_bot', '~> 2.25', '>= 2.25.1', require: false
  gem 'rubocop-performance', '~> 1.21', require: false
  gem 'rubocop-rails', '~> 2.24', '>= 2.24.1', require: false
  gem 'rubocop-rspec', '~> 2.29', '>= 2.29.1', require: false
end
