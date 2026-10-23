Feature: Personalized microlearning pathway (FR-11 – FR-15)

  Background:
    Given a goal "SQL quiz" with skills SELECT, WHERE, LEFT JOIN, GROUP BY, HAVING
    And HAVING requires LEFT JOIN and GROUP BY
    And the student's mastery is SELECT 0.93, WHERE 0.90, LEFT JOIN 0.62, GROUP BY 0.35, HAVING 0.12

  Scenario: Locked units are never planned
    When the pathway is computed
    Then no unit of HAVING is eligible
    And units of LEFT JOIN and GROUP BY are eligible

  Scenario: Today's plan fits the free time
    Given the student checked in with energy 3 and 40 free minutes
    When today's micro-plan is built
    Then the planned minutes are at most 40
    And every plan item has a non-empty reason

  Scenario: Reason matches the strongest factor
    Given a Databases deadline in Moodle is 3 days away
    When today's micro-plan is built
    Then the first unit's reason mentions the Databases deadline
    And the deadline factor is the largest weighted factor of that unit

  Scenario: Due review re-enters the plan
    Given ORDER BY was mastered 7 days ago and its review is due today
    When today's micro-plan is built
    Then a review item for ORDER BY is included
