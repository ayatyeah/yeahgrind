Feature: Accounts, consent and data rights (FR-01 – FR-04)

  Scenario: Another user's resources are not accessible
    Given users Aigerim and Dana each have a private goal
    When Aigerim requests Dana's goal by ID
    Then the response status is 404

  Scenario: Analytics are not collected before consent
    Given Aigerim has not opted in to learning analytics
    When she completes a unit
    Then no analytics event is stored
    But her learning progress is stored

  Scenario: Account deletion removes all user-owned data
    Given Aigerim has goals, attempts, videos shared to friends and feed events
    When she deletes her account
    Then no row in any user-owned table references her ID
    And her private media objects are deleted from storage
