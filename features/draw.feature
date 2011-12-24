Feature: Draws
  In order for customers to draw money and incur fees/interest
  A line of credit should be able to be drawn on

  Scenario: Draw maximum amount
    Given I have a new line of credit
    And my credit limit is $500
    And I draw $500
    Then my available credit should be $0
