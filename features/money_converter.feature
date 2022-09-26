Feature: Convert money
   As a visitor 
   I want to be able to sign in 
   So that I can access money converter area 

   Scenario: I can sign in 
        Given Iam on the homepage
        And I should see sign in button, if not logged in
        When I click on sign in link
        Given a valid user
        And I fill in and submit the sing in form 
        Then I should see confirmation message signed in successfully
        And I should see the converter form


     