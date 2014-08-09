Feature: tweets

Background:
	Given i Sign In as "shaunak@amuratech.com"

Scenario:view timeline
	When i click on timeline
	Then page should show content "Listing tweets"

Scenario:create a tweet
	Given i create a tweet "hello world5"
	When i am on index page
	Then page should show tweet "hello world5"

Scenario:view a tweet
	Given i create a tweet "helloworld6"
	When i click on eyefavicon
	Then page should go to show page

Scenario:edit a tweet
	Given i create a tweet "helloworld6"
	When i click on pencilfavicon
	Then page should go to edit page

Scenario:like a tweet
	Given i create a tweet "helloworld7"
	When i click on Like
	Then likes should increase by 1	

Scenario:unlike a tweet
	Given i liked a tweet "helloworld7"
	When i click on Unlike
	Then likes should decrease by 1	

Scenario:delete a tweet
	Given i create a tweet "helloworld8"
	When i click on close
	Then page should not have "helloworld8"	