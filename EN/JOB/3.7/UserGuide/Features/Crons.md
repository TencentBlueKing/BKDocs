# Timed tasks

In addition to direct execution, the job also supports scheduled execution. The scheduled task function is used to manage scheduled job tasks. In addition, due to the particularity of the scheduled scenario, the execution result feedback cannot be obtained immediately, so the `period success rate is introduced. ` The statistical method helps users to confirm which tasks fail to execute during the loop execution process.

![image-20211009174841530](media/image-20211009174841530.png)

## Timing task list

- mission name

   - the name of the cron job

- Execution plan name

   - The name of the job execution plan associated with the scheduled task

- Execution strategy

   - Timed strategy, `periodic execution` displays the expression, `single execution` displays the execution time

- updater

   - Who last edited the task

- update time

   - when the task was last edited

- Latest execution results

   - the result of the last execution of this task

- cycle success rate

   ![image-20200424104633465](media/image-20200424104633465.png)

   - The periodic execution success rate of the scheduled task enables users to see the latest execution status of the scheduled task more intuitively. If the success rate is not 100%, the failed task information will be displayed after the mouse hovers; due to the difference in the length of the execution cycle, Single/multiple times, so the calculation formula of the success rate will be matched with different types of expressions defined by the user. The rules are as follows:

     - Sampling rules:
         - If the number of executions in the last 24 hours > 10, the "denominator" is the total number of executions in the last 24 hours
         - If the number of executions in the last 24 hours is ≤ 10, then the "denominator" is the last 10 executions

     - Calculation formula:
         - Number of successes (numerator) / denominator * 100 = cycle success rate (%)


- operate

   - switch

     Turn on/off scheduled tasks

   - edit

     Edit the configuration of a scheduled task

   - delete

     Delete the corresponding scheduled task

   - Execution log

     View the execution record of the corresponding scheduled task



## Create a new scheduled task

Click the "**New**" button in the upper left corner of the list page to create a new scheduled task

![image-20211009175259494](media/image-20211009175259494.png)

- mission name

   The name of the scheduled task (set a recognizable name according to the scheduled execution scenario)

- Execution strategy

   - single execution

     Just like an alarm clock, set a future time point, and the task will only be triggered once at that time point

   - Periodic execution

     The same expression as Linux Crontab is adopted, which makes the threshold of use lower and easier to get started

- job templates

   Select the job template to which the scheduled task belongs

- action plan

   Set an execution plan from the selected job template