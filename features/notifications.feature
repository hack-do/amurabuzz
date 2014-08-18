Feature:View Notifications
In order to view notifications 
As a user
I should go to Notifications page

Background:
	Given i Sign In as "shaunak@amuratech.com"
	And another valid user exists

Scenario: View my notifications
	Given i create a tweet "helloworld"
	When i visit notifications page
	And i click on My Activities
	Then page should show "You posted a tweet"