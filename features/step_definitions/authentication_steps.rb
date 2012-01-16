Given /^a user exists with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  User.create!(name: email, email: email, password: password, password_confirmation: password)
end

When /^I try to sign in with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  visit new_user_session_path
  fill_in "Email", with: email
  fill_in "Password", with: password
  click_button "Sign in"
end

Then /^show me the page$/ do
  save_and_open_page
end

When /^I try to sign in (\d+) times with email "([^"]*)" and password "([^"]*)"$/ do |repeat, email, password|
  repeat.to_i.times do
    step "I try to sign in with email \"#{email}\" and password \"#{password}\""
  end
end

Then /^I should see "([^"]*)"$/ do |content|
  assert page.has_content?(content)
end

Given /^no user exists with email "([^"]*)"$/ do |email|
  assert ! User.find_by_email(email)
end

When /^I request a new password for "([^"]*)"$/ do |email|
  visit new_user_password_path
  fill_in "Email", with: email
  click_button "Send me reset password instructions"
end

Then /^I should not see "([^"]*)"$/ do |content|
  assert ! page.has_content?(content)
end
