
Feature: Log into app

  Scenario: User logs into the app
    Given A user inserts an email
    And A user inserts a password
    When The user hits Login button
    Then The user is logged in