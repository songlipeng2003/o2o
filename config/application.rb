require File.expand_path('../boot', __FILE__)

require 'rails/all'

# elasticsearch
require 'elasticsearch/rails/instrumentation'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Didi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Beijing'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'zh-CN'

    # api
    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]

    # raw upload
    config.middleware.use 'Rack::RawUpload'

    # ckeditor
    config.autoload_paths += %w(#{config.root}/app/models/ckeditor)

    config.middleware.use Rack::Cors do
        allow do
          origins '*'
          # location of your API
          resource '/api/*', :headers => :any, :methods => [:get, :post, :options, :put, :delete]
          resource '/store_api/*', :headers => :any, :methods => [:get, :post, :options, :put, :delete]
        end
    end
  end
end
