require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AmpCacheTest
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.time_zone = 'Tokyo'
    # curl -I http:/lvh.me:3002/.well-known/amphtml/apikey.pub
    # ルーティングを作って返してもよいはず
    Rack::Mime::MIME_TYPES[".pub"]="text/plain"

    if Rails.env.production?
      config.assets.compress = true
      config.assets.quiet = true
      config.active_record.logger = nil
      config.lograge.enabled = true
      config.lograge.custom_payload do |controller|
        {
          user_agent: controller.request.user_agent,
        }
      end    
    end
  end
end
