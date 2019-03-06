# functional regression test
  
@skip_if_failed @functional
Feature: Functional Weather site check

  Background:
    Given Weather site is accessible

  @api @ui
  Scenario Outline: Check site functionality via HTTP API and UI
    When current weather info for <city> is collected via <source>
    Then <source> weather data validation for <city> is successful
    Examples:
      | city      | source |
      | Cupertino | API    |
      | Cupertino | UI     |
      | Moscow    | API    |
      | Moscow    | UI     |
      | Barcelona | API    |
      | Barcelona | UI     |

  @ui @api
  Scenario: Compare API and UI weather data
    When current weather info for Cupertino is collected via API
    And current weather info for Cupertino is collected via UI
    Then API and UI weather info for Cupertino matches