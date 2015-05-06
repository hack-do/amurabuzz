Feature:Follow/Unfollow friends

Background: 
Given i Sign In as "shaunak@amuratech.com"
And another valid user exists

Scenario: view all users
Given i am on friends page
When i click on Make friends
Then page should display another users email

Scenario: follow a user
Given i am on all users page
When i click on Follow of another user
And i visit friends page
Then that user should be in my following table

Scenario: unfollow a user
Given i am on friends page
And i am following a user
When i click on Unfollow
Then that user must not be in my following table