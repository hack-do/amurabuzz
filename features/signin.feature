Feature: SignIn User
In order to signin 
As a Valid User
I should visit Sign in page And fill credentials


Scenario:Sign In
	Given i am a valid user with email "shaunak@amuratech.com" and password "secretpassword"
	And i visit Sign in page
	And i fill in email with "shaunak@amuratech.com"
	And i fill in password with "secretpassword"
	When i click on Sign in
	Then page should show message "successfully"
