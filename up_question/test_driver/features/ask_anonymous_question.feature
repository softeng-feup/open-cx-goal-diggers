Feature: Anonymous question

  Background: User logs into the app
    Given A user inserts an email
    And A user inserts a password
    When The user hits Login button
    Then The user is logged in

  Scenario: User can ask a question anonymously
    Given The user has logged in to the application
    And participant has selected the right conference
    And participant has written a question
    When participant checks the checkbox 'anonymous'
    And participant presses the question share button
    Then the participant asked a question without revealing his identity