Feature: User Access Posts

  Scenario: Accessing posts as a logged-in user
    Given the following user exists:
      | full_name             | ayaya  |
      | email                 | ayaya@email.com|
      | password              | 123456 |
      | password_confirmation | 123456 |
    And I am logged in as "ayaya@email.com" with password "123456"
    And the following posts exist for the user "ayaya@email.com":
      | title       | my beautifil house |
      | description | This is the first. |
      | address     | via di milano 3    |
      | city        | Rome               |
      | price       | 300000             |
      | numer_rooms | 4                  |
      | square_feet | 500                |
      | floor       | 1                  |
    When I visit the posts page
    Then I should see the following posts:
      | title       | my beautifil house |
      | address     | via di milano 3    |
      | city        | Rome               |
      | price       | 300000             |
      | numer_rooms | 4                  |
      | square_feet | 500                |
      | floor       | 1                  |