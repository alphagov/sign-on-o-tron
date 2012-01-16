Feature: User suspension
  Scenario: Suspended accounts can't sign in
    Given a user exists with email "email@example.com" and password "some password with various $ymb0l$"
    And "email@example.com" is a suspended account
    When I try to sign in with email "email@example.com" and password "notreally"
    Then I should see "Invalid email or password."