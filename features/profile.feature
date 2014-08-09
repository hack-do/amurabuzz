Feature:View and edit Profile

In order to view/edit profile
As a user
I should go to profile(me) page

Background:
Given i Sign In as "shaunak@amuratech.com"
And another valid user exists

Scenario: visit my profile
	When i click on Me button
	Then i should go to profile page

Scenario: edit my profile
	Given i visit my profile
	When i click on Edit
	Then i should go to Edit registration page