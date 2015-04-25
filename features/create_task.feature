Feature: Create tasks

  As a user I can create a task

  Scenario: I log in and see a project page
    Given I am an authenticated user
    And I create the following tasks
    When I go to the default project page
    Then I should see the following tasks
      # Put task list here
    When I go to the task page titled <TaskName>
    Then I should see...

