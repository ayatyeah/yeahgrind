Feature: Short-form video generation (FR-19 – FR-24)

  Scenario: First request creates a job, second reuses the video
    Given unit "LEFT JOIN — keep all rows" version 3 has no Russian video
    When the student requests the Russian video
    Then the response status is 202 with a queued job
    When the job succeeds and the video is requested again
    Then the response status is 200
    And no new LLM or TTS call is made

  Scenario: Ungrounded script is not published
    Given the generated script contains a sentence without a source reference
    When the pipeline validates the script
    Then the video status is "needs_review"
    And the video is not visible to students
    And the item appears in the moderation queue

  Scenario: Output meets format requirements
    When a video job succeeds
    Then the MP4 duration is between 60 and 120 seconds
    And the file has an audio track
    And a WebVTT caption file exists

  Scenario: Kazakh narration is gated
    Given the Kazakh quality check has not been recorded
    When the student requests a Kazakh video
    Then the response status is 409
