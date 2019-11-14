Feature: Select Conference to ask questions

  Background: User logs into the app
    Given A user inserts an email
    And A user inserts a password
    When The user hits Login button
    Then The user is logged in

  Scenario: Logged in user asks question
    Given The user has logged in to the application
    When The user selects the conference "Data Science"
    Then The user can ask the question in the proper site