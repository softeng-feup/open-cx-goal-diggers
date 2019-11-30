Feature: Speaker can reply to questions
  Background: User logs into the app
    Given A user inserts an email
    And A user inserts a password
    When The user hits Login button
    Then The user is logged in

  Scenario: Logged in Speaker can reply to submitted questions
    Given participants have submitted their questions
    #And speaker has logged in to the application
    #And speaker has selected the right conference
    #When speaker sees the questions asked
    #Then the speaker can reply the questions asked