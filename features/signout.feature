Feature: SignOut User
In order to signout
As a Signed-in user
I should click on Logout in drawer


Scenario:Sign Out
	Given i Sign In as "shaunak@amuratech.com"
	When i Click on "Welcome"
	When i click on Logout
	Then page should show signed out message "Signed out successfully"
