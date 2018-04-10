source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.2'
gem 'mysql2'
gem 'puma'
gem 'bootsnap'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'bcrypt'
gem 'nokogiri'
gem 'rails-i18n'
gem 'kaminari'
gem 'date_validator'

group :development do
  gem 'byebug', platform: :mri, group: :test
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'bullet'
  gem 'better_errors'
  gem 'rack-mini-profiler'
  gem 'pry-rails', group: :test
  gem 'rubocop', group: :test, require: false
end

group :test do
  gem 'rspec-rails', group: :development
  gem 'factory_bot_rails', group: :development
  gem 'rails-controller-testing', group: :development
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'simplecov'
  gem 'faker', group: :development
  gem 'faker-japanese', group: :development
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
