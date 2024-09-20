# Rolling execution

When we have a task that needs to be executed on many servers (hundreds or even thousands, tens of thousands), in order to avoid the impact on the service due to excessive concurrency, or to gradually observe the effect after execution, we can use This function performs rolling execution in batches;

![image-20230327114524491](media/image-20230327114524491.png)

- rolling strategy

   Follow the standard specifications established by the job platform, and indicate your batch strategy with expressions
   - expression specification
     - Each placeholder is separated by a `space`
     - Each placeholder is only allowed to appear `n` `n%` `*n` `+n`, and `n` can only be an integer
     - `100%` is only allowed at the end
     - Operators (`*` and `+`) are only allowed before the number n
     - Expressions (such as `+n` or `*n`) are only allowed at the end
     - `0` is not allowed
   - Explanation of meaning
     -n
     n must be an integer value, representing the specific number of units
     -n%
     n must be an integer value, representing n percent of the total amount (rounded up when a decimal point is encountered)
     - +n
     Represents the addition of n units on the basis of the previous batch each time
     -*n
     Represents multiplying the number of previous batches by n units each time

- scrolling mechanism

   Set what mechanism to use when various situations occur during the scrolling of the task (such as ignore, suspend, terminate, etc.)
   - default (pause if execution fails)
     When the execution fails in the middle batch, the task will be temporarily suspended, waiting for the user's instruction to continue or completely terminate
   - Ignore failures and roll the next batch automatically
     Even if there is an execution failure during the rolling period, the task will be ignored until all batches are executed
   - Not automatic, manual confirmation for each batch
     Each batch is paused for user confirmation to execute the action (continue or abort)

- example
I have 100 hosts that need to be processed, but I want to execute them in batches. The first batch will be fixed at 20 hosts, and then each batch will gradually increase the number until all are executed:
```
20 +10
```

![image-20230327115715266](media/image-20230327115715266.png)