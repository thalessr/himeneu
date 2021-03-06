require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Himeneu
  class Application < Rails::Application

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Brasilia'
    config.i18n.available_locales = [:en, 'en-US', :pt, :"pt-BR", :es]
    config.i18n.default_locale = :"pt-BR"
    config.assets.paths << Rails.root.join("vendor","assets", "bower_components")
    config.assets.precompile += %w( foo.js )

    if Rails.env.production?
      config.cache_store = :redis_store, 'redis://104.236.232.221:6379/0/cache', { expires_in: 180.minutes }
    else
      config.cache_store = :redis_store, 'redis://localhost:6379/0/cache', { expires_in: 90.minutes }
    end

    # config.cache_store = :redis_store, 'redis://localhost:6379/0/cache', { expires_in: 90.minutes }
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    config.active_record.raise_in_transactional_callbacks = true

  end
end
