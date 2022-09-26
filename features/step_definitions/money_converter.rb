# Given('registered user with the email with password exists') do 
#     @user = Factory(:registered_user, :email => "ahmed@example.com", :password => "123456", :password_confirmation => "123456")
# end

# Given('registered user with the email with password exists') do 
# @user = Factory(:registered_user, :email => "ahmed@example.com", :password => "123456", :password_confirmation => "123456")
# end

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
    # expect(current_url).to eq(root_path)
end
  
And('I should see the converter form') do
    expect(page).to have_link("destroy_session_link")
    # expect(response).to be_redirect
    # expect(current_url).to eq(root_path)
end
