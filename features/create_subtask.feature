Feature: Create tasks

  As a user I can create a subtask. This also tests the story that as a user I can create a task and see it
  on my project page.

  Scenario: I log in and see a project page
    Given I am an authenticated user
    And I create the following tasks
      # Put task list here
    When I go to the task page titled <TaskName>
    When I go to the default project page
    Then I should see the following tasks
      # Put task list here
    When I go to the task page titled <TaskName>
    Then I should see...
