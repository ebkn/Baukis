require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Baukis
  class Application < Rails::Application
    config.time_zone = 'Asia/Tokyo'
    config.i18n.load_path +=
      Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ja
    config.generators do |g|
      g.helper false
      g.assets false
      g.test_framework :rspec, fixtures: true,
                               view_specs: false,
                               helper_specs: false,
                               routing_specs: false,
                               controller_specs: true,
                               request_specs: false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
  end
end
