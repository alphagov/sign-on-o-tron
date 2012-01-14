Given /^a user exists with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  User.create!(name: email, email: email, password: password, password_confirmation: password)
end

When /^I try to sign in (\d+) times with email "([^"]*)" and password "([^"]*)"$/ do |repeat, email, password|
  repeat.to_i.times do
    visit new_user_session_path
    fill_in "Email", with: email
    fill_in "Password", with: password
  end
end

