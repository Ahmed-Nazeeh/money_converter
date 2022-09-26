Given('Iam on the homepage') do
    visit "/"
end

When('I click on the rigestration link') do
    click_on "registration-link"
end

When('I fill in and submit the registration form') do
    fill_in "user_name", with: "ahmed"
    fill_in "user_email", with: "ahmed@example.com"
    fill_in "user_password", with: "123456"
    fill_in "user_password_confirmation", with: "123456"
    click_on "user_registration_submit"
end

Then('should see a registration confirmation message') do
    expect(page).to have_content("Welcome")
end

Then('I should receive a confirmation email') do
    steps %{"ahmed@example.com" should receive an email}
end