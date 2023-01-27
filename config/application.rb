require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

key_file = File.join 'config', 'master.key'
ENV['RAILS_MASTER_KEY'] = File.read key_file if File.exist? key_file

# The default locale loading mechanism in Rails does not load locale files in
# nested dictionaries, like we have here. So, for this to work, we must
# explicitly tell Rails to look further:
config.i18n.load_path += Dir[Rails.root.join('config', 'locales',
                                             '**', '*.{rb,yml}')]

module Source
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
