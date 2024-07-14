Feature: User Creation

    Scenario: Creating a new user
        When I create the following user:
            | full_name             | ayaya |
            | email                 | ayaya@email.com |
            | password              | 123456 | 
            | password_confirmation | 123456 |
        Then I should have the following user:
            | full_name             | ayaya |