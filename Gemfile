source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails',  '~> 5.2.3'
gem 'pg',     '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'slim', '~> 4.0'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'bootstrap',                              '~> 4.1.3'
gem 'font-awesome-sass',                      '~> 5.6.1'
# gem 'jquery-rails',                           '~> 4.3.3'
# gem 'jquery-ui-rails',                        '~> 6.0.1'
# gem 'sass-rails',                             '~> 5.0.7'
gem 'simple_form',                            '~> 4.1.0'


group :development do
  gem 'web-console',                        '>= 3.3.0'
end

group :development, :test do
  gem 'rubocop',                            '~> 0.56.0', require: false
  gem 'binding_of_caller',                  '~> 0.8.0'
  gem 'pry-byebug',                         '~> 3.6.0'
  gem 'pry-rails',                          '~> 0.3.9'
  gem 'faker' ,                             '~> 1.9.1'
  gem 'launchy',                            '~> 2.4.3'

  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring',                             '~> 2.0.2'
  gem 'spring-commands-rspec',              '~> 1.0.4'
  gem 'spring-watcher-listen',              '~> 2.0.0'

  gem 'factory_bot_rails',                  '~> 4.11.1'
end

group :test do
  gem 'capybara'
  gem 'minitest-reporters'
  gem 'rspec-rails',                        '~> 3.8'
  gem 'selenium-webdriver',                 '~> 3.141.0'
  gem 'shoulda',                            '~> 3.6.0'
  gem 'shoulda-matchers',                   '~> 3.1.3'
  gem 'shoulda-callback-matchers',          '~> 1.1.4'
  gem 'rails-controller-testing',           '~> 1.0.4'
  gem 'simplecov', require: false
end
