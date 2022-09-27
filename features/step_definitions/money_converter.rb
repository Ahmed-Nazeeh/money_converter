
Given('Iam on the home page') do
    visit "/"
end

And('I should see sign in button, if not logged in') do
    expect(page).to have_link('sign_in_link')
    expect(page).to have_link('registration-link')
end

When('I click on sign in link') do
    click_on "sign_in_link"
end

Given('a valid user') do
  @user = User.create!({
             :email => "ahmed@example.com",
             :password => "123456",
             :password_confirmation => "123456"
           })
  @user.save!
end

When('I fill in and submit the sing in form') do
    fill_in "user_email", with: "ahmed@example.com"
    fill_in "user_password", with: "123456"
    click_on "user_sign_in_submit"
end


Then('I should see confirmation message signed in successfully') do
    expect(page).to have_content("successfully")
end
  
And('I should see the converter form') do
    expect(page).to have_link("destroy_session_link")
    expect(page).to have_content("Enter value")
end

When('I fill in and submit the converter form') do
    fill_in "enter_value", with: 1000
    select "usd" , from: "convert_from"
    select "usd", from: "convert_to"
    click_on "submit"
end
  
Then('I should see the results in the result fields') do
   expect(page.results).to have_include(1000)
end
