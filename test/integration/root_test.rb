require 'test_helper'

class SubredditNavigationTest < ActionDispatch::IntegrationTest
  setup do
    Capybara.current_driver = :webkit #Capybara.javascript_driver # :selenium by default
  end

  test 'root page has New Subreddit link' do
    visit('')
    a = first("a", :text => 'New Subreddit')
    assert a.visible?
  end
end
