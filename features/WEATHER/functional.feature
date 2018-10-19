@skip_if_failed @functional
Feature: Functional Weather site check

  @ui
  Scenario: Compare API and UI weather data
    Given Weather site is accessible
    When current weather info for Cupertino is collected via API
      And current weather info for Cupertino is collected via UI
    Then API and UI weather info for Cupertino matches