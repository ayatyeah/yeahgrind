Feature: Adaptive knowledge assessment (FR-25 – FR-30)

  Scenario: Next item targets about 70 % success
    Given a learner ability of 0.4
    And validated items of LEFT JOIN with difficulties -1.0, 0.0, -0.45, 1.2
    When the next item is selected
    Then the item with difficulty -0.45 is chosen
    And no item already answered in this quiz is chosen

  Scenario: Correct answer increases mastery and ability
    Given LEFT JOIN mastery is 0.62
    When the learner answers a LEFT JOIN item correctly
    Then LEFT JOIN mastery is greater than 0.62
    And the learner ability increases
    And the item difficulty decreases

  Scenario: Retried submission has no extra effect
    Given an answer was submitted with idempotency key K
    When the same answer is submitted again with key K
    Then the stored result is returned
    And mastery, ability and rewards do not change again

  Scenario: Answer is never revealed before an attempt
    When the client requests the question and both hints
    Then no response contains the answer key

  Scenario: Quiz stops early when mastery is confident
    Given LEFT JOIN mastery reaches 0.86 after 4 answers
    When the next item is requested
    Then the quiz is finished with 4 items used
