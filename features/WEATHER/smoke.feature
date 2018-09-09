@skip_if_failed
Feature: Weather site check

  @smoke
  Scenario: Check Weather site availability
    Given Weather site is accessible
    Then I get basic city info for Cupertino via API

  @functional @api
  Scenario: Check site functionality via HTTP API
    Given I get current weather for Cupertino via API
    Then I check that API weather data for Cupertino is valid

  @functional @ui
  Scenario: Check site functionality via UI
    Given I get current weather for Cupertino via UI
    Then I check that UI weather data for Cupertino is valid
