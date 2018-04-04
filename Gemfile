source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.6'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'puma', '~> 3.0'
gem 'haml-rails'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'jquery-ui-rails', '~> 6.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt'
gem 'nokogiri'
gem 'rails-i18n'
gem 'kaminari'
gem 'date_validator'

group :development do
  gem 'byebug', platform: :mri, group: :test
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'bullet'
  gem 'better_errors'
  gem 'rack-mini-profiler'
  gem 'pry-rails', group: :test
  gem 'rubocop', group: :test
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
