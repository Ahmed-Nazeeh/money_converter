
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
             :name => "Ahmed",
             :password_confirmation => "123456"
           })
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
    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_link("Exchange")
end

When('I click on Exchange button') do 
    click_on("Exchange")
end

Then('I should see the exchange form') do 
    expect(page).to have_content('Enter value')
end

And('I fill in and submit the converter form') do
    fill_in "enter_value", with: 100
    select "USD" , from: "convert_from"
    select "USD", from: "convert_to"
    click_on "submit"
end
  
#Then Test turbo results with rspec in the requests section