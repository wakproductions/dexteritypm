## Dexterity PM Basic Concepts

This is an overview of the basic concepts which are planned to be integrated into Dexterity PM. Not all of them
have been developed yet.

### Users
* Users belong to a project. There need not be a project owner. There need not be permissions except for which projects a user can see.
* A user should not be able to see a project he’s not a part of.
* A user can have a default project so when he logs in he goes to that project’s page automatically.

### Projects
* Projects are top level aggregators for tasks. This allows a single user to have multiple projects they can work on within DexterityPM.

### Tasks
* Tasks can be broken down into subtasks. This framework acknowledges that some tasks are big while others are small and easy to tackle.
* A task can be labeled a group, or a task. The groups don’t have data associated with them, their only purpose is for aggregating tasks and they appear differently in the headers. Some of the groups might create may include: An icebox group for new ideas, groups by feature or major component of a system...
* You can create subtasks from within a task. You can only move a task from one group to another, not to another task. (Because it doesn’t make sense to move something to another subtask)
* A task can represent a user story or use case, but it can also represent other things such as a bug report, administrative/system configuration piece of work, or a specific piece of the system that needs to be worked on in order for the larger user story to work. Here are some ideas for task categories:
    * feature - a user story, use case, or some subcomponent
    * todo - a miscellaneous task that needs to be completed
    * bug - bug fix
    * aesthetic - UX / or design related aspect
    * technical - a technical component of the system that needs to be build or set up, not necessarily directly noticable to the end-user
    * group - this will be deprecated and put into a new boolean field since a group is not a type of task.
* A task can have optional fields attached to it. Recommended ones include:
    * Title (may be the same as user story line)
    * Tags
    * User story line
    * Acceptance criteria
    * Additional details
    * Attached files or images
* There should be an additional safeguard to prevent a task from being assigned to a project which it doesn’t belong. Thinking about making an internal field that doesn’t change like “PROJECTID-TASKID” as a backstop so that project ID can’t change and also to use as a universal identifier.
* A task has a status: planning, pending, in_process, done, and TBD (still deciding whether it will be implemented)
* Acceptance criteria: for now, we’re going to use the “description” part of the task to outline the acceptance criteria. One thing I would like to do eventually is use Markdown to allow more detailed descriptions. Another thing we can do is have a separate acceptance criteria field. Maybe you can add a bunch of different boxes and call them whatever you wish (user story description, acceptance criteria).
* Checklist: a check list of items could be attached to a task such as “rspec” test or “cucumber test”. Acceptance criteria could be made into a checklist.
* A task can be assigned to a user.
* An estimated completion time can be assigned to a task.

### Task buckets
* Tasks can be aggregated into higher level groups called task buckets. For example, you might be working in a different bucket for different subcomponents of a system. You might even use buckets to group tasks into release numbers. Buckets give you a means of archiving old tasks.