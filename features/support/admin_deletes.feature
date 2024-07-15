Feature: an Admin searches and deletes a House post with incorrect information
	
    As an admin, I want to access the admin panel and delete posts with incorrect information to 	maintain the accuracy and quality of the posts on the platform.

Scenario: Admin deletes a post with incorrect information
	
    Given I am on the CaseVelocii homepage
	And I am logged in as an admin
	When I click on the user icon
	And I click on "Admin Panel"
	Then I should see the admin dashboard
	When I search for the post with incorrect informations
	And I find a post with incorrect information
	Then I click on the "Delete" button for that post
	Then the post should be removed from the platform
	And I should see a confirmation message that the post has been successfully deleted