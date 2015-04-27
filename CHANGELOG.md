## 1.0 (in progress)

### Technical Changes
* Created RSpec tests for Tasks
* Created skeleton work for using Cucumber tests, but no actual tests in place yet so do not use. May
  or may not implement depending on time available.
* Introduced Interactor gem
* Changed the way it labels Task groups from being a "group" category to having a group flag. The reason is
  because eventually we can make the categories configurable by the end user, and the aggregating of tasks
  into groups is a feature of the system. Also, a category is meant to denote the type of work being performed,
  and a group aggregator category does not fit this description.

### Technical Notes
* A Task should not be able to change from one project to another. Nor should a subtask be able to change its
  parent to a different task. (Subtasks are breakdowns of the work involved in doing a Task.) However, rather than
  complicating the Task model by using before/after hook validations for this, we believe it is better to implement
  this validation through an interactor.