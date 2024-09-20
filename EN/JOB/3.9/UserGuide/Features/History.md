# Execution history

The execution history page displays all historical execution tasks under the corresponding business, including tasks triggered through channels such as page execution, scheduled execution, and API calls; it also provides a convenient entry for "**redo**" on historical tasks to meet The user wants to repeat the execution of a historical task.

![image-20211009175410471](media/image-20211009175410471.png)

- Task ID

   The ID of each historical execution task is unique. If there is already a clearly known ID, you can directly locate the corresponding task through ID search

- mission name

   The task name can be repeated, because the same scene may be executed multiple times, and the same name can help users classify the execution records of the same scene

- Implementation modalities

   Indicates which channel is used to trigger the execution of the task. Channel sources include: `page execution` `timed execution` and `API call`

- task type

   Indicates the operation type of the task, including: `job execution` `script execution` and `file distribution`

- task status

   Indicates the current state of the task, including the following list:

   - pending execution

     Indicates that the task has not started and is in a waiting state; (the scene that appears may be that there are too many tasks in the queue and the tasks are queuing)

   - executing

     Indicates that the task is currently executing normally

   - execution succeed

     Indicates that the task has been successfully executed (tasks that automatically/manually ignore error handling are also classified into this state)

   - Execution failed

     Indicates that the execution of the task failed (if any server in the step fails to execute, it will be regarded as an execution failure)

   - Waiting for confirmation

     Indicates that it is currently in the manual confirmation step, waiting for the user to confirm whether to continue

   - Confirm termination

     Indicates that the user manually confirms the termination of the task and will not continue to execute

   - Forced termination

     Indicates that the user has triggered the `forced termination` action and is currently in the process of forced termination

   - force terminated successfully

     Indicates that the user's `forced termination` command has been successfully executed, and the task process on the execution target has been stopped

   - Forced termination failed

     Indicates that the execution of the user's `forced termination` instruction failed, and the task on the execution target may still be executing

   - thrown away

     Indicates that the task has been discarded by the execution engine and will no longer continue to run (if the executing task is discarded, the execution target may still be executing)

- Executor

   Task performer's name

- Starting time

   Indicates the point in time when the task starts to execute

- time-consuming

   Indicates the time spent on task execution