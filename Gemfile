source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.3'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# helps rails console readability
gem 'pry-rails'

# helps with user authentication
gem 'devise'

# oauth
gem 'omniauth-facebook'

# helps with attribute boilerplate on POROs
gem 'virtus'

# date picker
gem 'bootstrap-datepicker-rails'

# time picker
gem 'bootstrap-timepicker-rails', 
  :require => 'bootstrap-timepicker-rails', 
  :git => 'git://github.com/tispratik/bootstrap-timepicker-rails.git'

gem 'bootstrap-sass'

# autocomplete functionality
gem 'jquery-ui-rails'

# helps with s3 avatar upload
gem 'paperclip', '~> 5.2.1'
gem 'aws-sdk', '>= 2.0'

# helps with file submission via ajax
gem 'remotipart', '~> 1.2'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  # test suite
  gem 'rspec-rails', '~> 3.6'

  # watcher for test suite
  gem 'guard-rspec', require: false

  # add-on for data management in testing
  gem 'factory_girl_rails'

  # makes sure our db doesn't have residual objects
  gem 'database_cleaner'

  # additional add-on for rspec testing ease
  gem 'shoulda-matchers'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
