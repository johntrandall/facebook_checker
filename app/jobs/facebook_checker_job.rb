class FacebookCheckerJob < ApplicationJob

  def perform(name_to_find = nil)
    name = name_to_find || Rails.application.credentials.name_to_search
    puts Time.now

    session = Capybara.current_session
    # driver_browser = browser.driver.browser

    session.visit "https://facebook.com"

    session.fill_in 'email', with: Rails.application.credentials.facebook[:user]
    session.fill_in 'pass', with: Rails.application.credentials.facebook[:pass]
    session.click_button 'Log In'

    chat_list_item = session.first('div[data-pagelet="RightRail"] li', exact_text: name)
    puts "found #{name}"
    CheckResult.create!(name: name, result: 'found')

  rescue Capybara::ExpectationNotMet => e
    puts "did not find #{name}"
    CheckResult.create!(name: name, result: 'not found')
  end
end
