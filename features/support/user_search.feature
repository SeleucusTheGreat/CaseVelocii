Feature: A new user Searches for a house near where he lives

	As a logged-in user, I want to search for houses close to where I live so I can find my next 	house near my current location.

Scenario: User searches for a house using address and radius
	Given I am on the CaseVelocii homepage
	And I am logged in
	When I enter my address and a specific radius of distance in the Search bar
	And I enter the name of my city
	And I click on Search
	Then I should see posts regarding houses in my city
	And the posts should be within the specified radius of my address
	When I click on one of these posts
	Then I should see detailed information about the house 
	 And I should see a map with the address of  the house displayed