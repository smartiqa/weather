@skip_if_failed @functional
Feature: Weather site check

  Scenario: Compare API and UI weather data
    Given Weather site is accessible
    Then API and UI weather info for Cupertino matches