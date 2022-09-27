Feature: User registration
         As a first-time visitor
         I want to be able to create an account
         so that I can access the members area

         Scenario: I create an account
         Given Iam on the homepage
         When I click on the rigestration link
         And I fill in and submit the registration form
         Then should see a registration confirmation message
         And I should see my name on the page
         And I should receive a confirmation email