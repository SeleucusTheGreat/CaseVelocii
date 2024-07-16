

Feature: A registered User Starts a new chat about a house post 

	As a logged-in user, I want to initiate a conversation with the owner of a house post I'm 	interested in, so that I can inquire about the property.

Scenario: User starts a new chat from a house post

	Given I am on CaseVelocii homepage
	And I am logged in
	When I click on a house post that interests me
	Then I should see the details of the house post
	And I should see a Send Message and a text box
	Then I write a new message
	And  I click on Send Message
	Then A new chat should be created between me and the House owner
	When I visit my UserPage
	Then A new chat should be visible
	And it should display the other user's profile picture and name
	And it should show the associated post's image and title
	And it should display the last message exchanged