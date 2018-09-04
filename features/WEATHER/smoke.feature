Feature: Weather site check

  @smoke
  Scenario: Check Weather site availability
    Given Weather site is accessible
    Then I get basic city info for Mountain View via API

  @functional @api
  Scenario: Check site functionality via HTTP API
    Given I get current weather for Mountain View via API
    Then I check that weather data for Mountain View is valid

  @functional @ui
  Scenario: Check site functionality via UI
    Given I get current weather for Mountain View via UI