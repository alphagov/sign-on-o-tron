Feature: Signing in
  Scenario: Successful sign in
    Given a user exists with email "email@example.com" and passphrase "some passphrase with various $ymb0l$"
    When I try to sign in with email "email@example.com" and passphrase "some passphrase with various $ymb0l$"
    Then I should see "Hello, email@example.com"
