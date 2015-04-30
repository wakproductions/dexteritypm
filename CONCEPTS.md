## Dexterity PM Basic Concepts

This is an overview of the basic concepts which are planned to be integrated into Dexterity PM. Not all of them
have been developed yet.

## Aggregation Concepts

Dexterity PM's goal is to blend the function of a ticket/case management system with the processes of Agile development.
It's driving concept is that work on a big-picture concept needs to be implemented in small scale steps. Therefore,
Dexterity PM allows ideas to be aggregated in a hierarchial fashion so that teams can communicate ideas on a scale
both large and small.

Each piece of work is broken down into tasks. A task can represent a single piece of work such as "set up database"
or a bigger concept such as an Agile user story. Tasks can be aggregated under larger tasks. Here are the levels of
aggregation:

    Project > Task Buckets > Task Groups > Tasks > Subtasks

Following is a more detailed explanation of the levels of aggregation.

### Users
* A user can work on multiple projects.
* At this point in time, there is no differentiation between users' roles on a project. All users are treated with the
  same level of access.
* The only permissions system is which projects a user can see and interact with.
* A user should not be able to see a project he’s not a part of.
* When a user logs in, he will be taken to the project page of the last project viewed.
* At this point it is up to the Rails system admin to create users through the Rails console because there is no
  self-registration system through the interface.

### Projects
* Projects are top level aggregators for tasks.
* At this point it is up to the Rails system admin to create projects through the Rails console because there is no
  project creation page.

### Task Groups
* Tasks can be aggregated into groups within a project. It is up to the end user how they want to use groups. We suggest
  using groups as a way of viewing the overall system to be build as components. For example, there might be a group
  for tasks associated with building the "Authentication" part of a system. Or another group for "Production Environment
  Configuration". A group can even be used to aggregate non-technical tasks. You might have a group labeled
  "Requirements Gathering" and a list of tasks representing meetings with specific people.

### Tasks
* A task can represent a user story or use case, but it can also represent other things such as a bug report, administrative/system configuration piece of work, or a specific piece of the system that needs to be worked on in order for the larger user story to work. Here are some ideas for task categories:
    * feature - a user story, use case, or some subcomponent
    * todo - a miscellaneous task that needs to be completed
    * bug - bug fix
    * aesthetic - UX / or design related aspect
    * technical - a technical component of the system that needs to be build or set up, not necessarily directly noticable to the end-user
    * group - this will be deprecated and put into a new boolean field since a group is not a type of task.
* A task can have optional fields attached to it. Fields we are planning on building include:
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
* An estimated completion time can be assigned to a task. Thinking about using Fibonacci sequences for time - planning poker style

### Subtasks
* Tasks can be broken down into subtasks. This framework acknowledges that some tasks are big while others are small and
  easy to tackle. We recommend naming top level tasks after user stories, and breaking down those user stories into
  smaller subtasks. For example, you might have a top level task titled: "As a user I view a list of products."
  This top level task can be broken down into subtasks such as:
    * "Build Product model and tests"
        * "Create filter functionality for products based on critera"
    * "Build Product listing page views"
    * "Design product page look and feel"
* Subtasks could become subtasks of other subtasks, but for simplicity we do not recommend going more than 3 levels deep.
* You create subtasks from within a task. You can only move a task from one group to another, not to another task. (Because it doesn’t make sense to move something to another subtask)

### Task buckets
* Tasks can be aggregated into higher level groups called task buckets. The most common use for a task bucket would be
  for archiving completed tasks. You may even create several different archive buckets representing different releases
  of a given piece of software.

### Sprints
* Tasks can be aggregated into sprints
* Sprints have a due date (i.e. 2 week sprints)


## Tasks vs Groups

From a system architecture standpoint, Tasks and Task Groups are the same object within the database. Tasks have a
group field which when true causes a task to be treated as a group by the user interface. The reason is because
groups are broken down into tasks, and tasks are broken down into subtasks. At this point we can keep the same
hierachy without the need for a separate model and database fields to represent TaskGroup's and the respective
associations. The interface should only allow a task to become a group if it is at the top level (i.e. has no parents).