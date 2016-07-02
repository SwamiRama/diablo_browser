source 'https://rubygems.org'

gem 'rails', '>= 5.0.0.rc1', '< 5.1'

gem 'figaro', '~> 1.1', '>= 1.1.1'

### Frontend ###
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'jquery-rails'
gem 'turbolinks', '~> 5.x'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

### Backend ###
gem 'pg', '~> 0.18.4'
gem 'puma', '~> 3.0'
gem 'redis', '~> 3.0'

gem 'devise', '~> 4.1', '>= 4.1.1'
gem 'devise-bootstrap-views', '~> 0.0.8'
gem 'omniauth-facebook', '~> 3.0'

gem 'diablo_api', '~> 1.0', '>= 1.0.1'

group :development, :test do
  gem 'byebug', platform: :mri

  gem 'rspec', '= 3.5.0.beta4'
  gem 'rspec-rails', '~> 3.5.0.beta4'
  gem 'rspec-core', '= 3.5.0.beta4'
  gem 'rspec-expectations', '= 3.5.0.beta4'
  gem 'rspec-mocks', '= 3.5.0.beta4'
  gem 'rspec-support', '= 3.5.0.beta4'

  gem 'timecop', '~> 0.8.1'
  gem 'guard', '~> 2.14'
  gem 'guard-rails', '~> 0.7.2'
  gem 'guard-rspec', '~> 4.7', '>= 4.7.2'
  gem 'guard-livereload', '~> 2.5', '>= 2.5.2'
  gem 'guard-bundler', '~> 2.1'
end

group :development do
  gem 'better_errors', '~> 2.1', '>= 2.1.1'
  gem 'binding_of_caller', '~> 0.7.2'

  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
