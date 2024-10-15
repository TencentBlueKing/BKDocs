# Why the steps of the job execution plan cannot be modified

> How to define a "qualified tool"? —— The capabilities of the tool should be clear to users at a glance!

When some users use the job function, they will find a special place, that is, the execution plan of the job cannot edit the content of the steps; then, for example, in the following case, I need to modify the script parameters before executing, what should I do? Wouldn't it be possible to modify the job template first and then execute the plan synchronously?

![image-20201106212919142](media/image-20201106212919142.png)

If your job is designed like the above example, unfortunately, when you need to adjust the script parameters to `gz 1` before executing, you can only do so by modifying the job template and then synchronizing to the execution plan.