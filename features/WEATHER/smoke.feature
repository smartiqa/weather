# functional regression test

@skip_if_failed @smoke
Feature: Smoke Weather site check

  Background:
    Given Weather site is accessible
      And basic city info for Cupertino retrieved via API

  @api
  Scenario: Check site functionality via HTTP API
    When current weather info for Cupertino is collected via API
    Then API weather data validation for Cupertino is successful

  @ui
  Scenario: Check site functionality via UI
    When current weather info for Cupertino is collected via UI
    Then UI weather data validation for Cupertino is successful
