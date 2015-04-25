Feature: View default project

  As a user when I log in, it takes me to my default project, which should be the same as the last project I viewed.
  If no default project is set (system has no record of the last project I viewed), it shows me the first project by
  alphbetical order.

  Scenario: I log in and see a project page
    # System has no record of the last project you viewed
    Given There is no default project set
    When I log in
    Then I should see the first project by title's alphabetical order
    # We're also attacking validation for viewing the project's tasks on the project page
    And I should see the following tasks
      # Put task list here

  Scenario: I log in and see the last project I viewed
    Given I previously viewed project number 2
    When I log in
    Then I should see project number 2
    And I should see a list of tasks

