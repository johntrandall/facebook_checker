require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'capybara'
  gem 'webdrivers' #, '~> 4.0', require: false
  # gem 'json', require: false
  # gem 'nap', require: 'rest'
  # gem 'cocoapods', '~> 0.34.1'
end

puts 'Gems installed and loaded!'

Capybara.run_server = false
# Capybara.javascript_driver = :chromedriver
Capybara.configure do |config|
  config.default_max_wait_time = 10 # seconds
  config.default_driver = :selenium
end

class FacebookChecker
  def self.go
    puts Time.now

    session = Capybara.current_session
    # driver_browser = browser.driver.browser

    session.visit "https://facebook.com"

    session.fill_in 'email', with: 'john@johnrandall.com'
    session.fill_in 'pass', with: 'VAShare1_@'
    session.click_button 'Log In'


    name = "Janet Liddell"
    chat_list_item = session.first('div[data-pagelet="RightRail"] li', exact_text: name)
    puts "found #{name}"

  rescue Capybara::ExpectationNotMet => e
    puts "did not find #{name}"
  end
end

FacebookChecker.go
