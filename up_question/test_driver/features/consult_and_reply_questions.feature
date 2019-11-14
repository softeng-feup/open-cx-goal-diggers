Feature: Speaker can reply to questions

  Scenario: Logged in Speaker can reply to submitted questions
    Given participants have submitted their questions
    And speaker has logged into the application
    And speaker selects the right conference
    When speaker sees the questions asked
    Then the speaker can reply the questions asked