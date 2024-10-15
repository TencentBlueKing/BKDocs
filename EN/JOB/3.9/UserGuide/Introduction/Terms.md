# Basic concept

This article introduces some terms and basic concepts unique to the BlueKing operating platform.

## Operation

Execution process customized to complete established tasks in terms of release changes, inspections, initialization, etc.;

In the job platform, jobs are divided into **template** and **execution plan**, both of which are in a **one-to-many** relationship;

That is, a job template can generate multiple execution plans, and the execution plan can be understood as a job instance derived from the template and strongly associated with the usage scenario.


## Global variables

For variables used globally by a single job template/execution plan, users can select the corresponding type of variable according to the needs of the scenario;

If you look at it from the perspective of "tool culture", the operation is like an electric fan, the global variable is the function button, and the operation steps are fan components such as fan blades/magnets/shafts. The fan will use the capabilities it can provide to** The function button ** is displayed on the outermost layer,

The purpose is to let users see the capabilities of the electric fan at a glance when they see the function buttons! The same is true for homework. What capabilities your homework provides, how you can use them, etc., can be satisfied by assigning different variable values. Users can know it by looking at the global variables, without having to check the homework steps one by one;

This is the idea of tool culture!

## Timing tasks

Similar to Linux's Crontab, you can set periodic execution tasks, and the operating platform also supports a "single execution" timing strategy;

And according to the usage scenario, it provides a message reminder function of timing start and end to help users grasp the task execution situation in a timely manner.

## Common script

In the operation platform, ordinary business will have its own script management space; and public script, just like its name, is oriented to business/users on all platforms in a "public" form, which satisfies the commonality scenario of multiple businesses Scripts need unified management and sharing requirements.


## IP Whitelist

Since the business in the job platform is logically isolated, that is, you can only execute associated scripts/jobs or hosts under the specified business, resources or targets are not allowed to be cross-business;

However, when users are in the platform business maintenance scenario, they need to transfer files/execute tasks across businesses. This is achieved by adding hosts outside the business to the IP whitelist.

(This function will be provided by configuring the "business set" of the platform in the future. At that time, the IP whitelist function will be removed after migration)