Feature: Social learning (FR-31 – FR-36)

  Scenario: Feed shows only permitted events
    Given Dana and Aigerim are friends and Arman is not Aigerim's friend
    And Dana mastered GROUP BY with visibility "friends"
    And Arman mastered HAVING with visibility "friends"
    When Aigerim opens the feed
    Then she sees Dana's event
    And she does not see Arman's event

  Scenario: Scores are private by default
    Given Dana finished a quiz with score 6 of 10
    When Aigerim opens the feed
    Then Dana's score is not shown

  Scenario: Group progress is cooperative
    Given the group "DB quiz squad" has a weekly target of 32 units
    And its 4 members completed 23 units this week
    When a member opens the group
    Then the progress shows 23 of 32
    And no ranking of members is shown

  Scenario: Rejected generated item is never served
    Given a moderator rejected question GROUP-BY-12
    When any quiz selects the next item for GROUP BY
    Then question GROUP-BY-12 is not selected
