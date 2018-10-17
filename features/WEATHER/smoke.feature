@skip_if_failed @smoke
Feature: Weather site check

  Scenario: Check Weather site availability
    Given Weather site is accessible
    Then I get basic city info for Cupertino via API

  @api
  Scenario: Check site functionality via HTTP API
    Given I get current weather for Cupertino via API
    Then I check that API weather data for Cupertino is valid

  @ui
  Scenario: Check site functionality via UI
    Given I get current weather for Cupertino via UI
    Then I check that UI weather data for Cupertino is valid
