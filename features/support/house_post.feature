

Feature: A registered User Creates a new post regarding one of his houses

  As a logged-in user, I want to create a new post about my house so that other interested users can see it.

  Scenario: User creates a House Post
    Given I am on the CaseVelocii homepage
    And I am logged in
    When I click on the user icon
    And I click on My Houses
    Then I should see a list of my houses
    And I click on Post a New House
    Then I should be able to fill out the form
    And I enter all the information required
    And I upload one or more pictures
    And I click on "Create"
    Then I should see a confirmation message that the post has been successfully created
    When I visit My Houses again
    And I should see the House post I’ve just created
    Then I click on the house I’ve just created
    And I should see all the details about the house 
    And they should be correct
