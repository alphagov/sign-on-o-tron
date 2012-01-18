Feature: Passphrase reset
  Scenario: Not showing too much information after failed request
    Given no user exists with email "email@example.com"
    When I request a new passphrase for "email@example.com"
    Then I should not see "Email not found"
