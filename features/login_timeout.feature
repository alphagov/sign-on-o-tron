Feature: Restrictions around login
  Scenario: Locking accounts after many failed login attempts
    Given a user exists with email "email@example.com" and passphrase "some passphrase with various $ymb0l$"
    When I try to sign in 7 times with email "email@example.com" and passphrase "notreally"
    Then I should see "Too many failed login attempts. Please wait an hour and try again or contact an admin."
