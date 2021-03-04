require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FacebookChecker
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # point to the heroku Chrome from heroku-buildpack-google-chrome
    #

    if ENV['HEROKU'].present?
      Selenium::WebDriver::Chrome.path = ENV['GOOGLE_CHROME_SHIM']
    end
    #
    # Capybara.register_driver :chrome do |app|
    #   Capybara::Selenium::Driver.new(app, browser: :chrome)
    # end
    #
    # Capybara.register_driver :headless_chrome do |app|
    #   capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    #     chromeOptions: {
    #       args: %w[headless enable-features=NetworkService,NetworkServiceInProcess]
    #     }
    #   )
    #
    #   Capybara::Selenium::Driver.new app,
    #                                  browser: :chrome,
    #                                  desired_capabilities: capabilities
    # end

    Capybara.default_driver = :selenium_chrome_headless
    Capybara.javascript_driver = :selenium_chrome_headless
  end
end


