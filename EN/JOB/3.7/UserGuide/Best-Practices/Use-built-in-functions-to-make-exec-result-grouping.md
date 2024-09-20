# Use the built-in function to realize the execution result grouping function

In daily operation and maintenance, we often encounter the need to count online server information. A common solution is to write the script logic of "processing login machine and obtaining information" on one operation and maintenance machine, and then Execute on multiple machines, record the results in the text, and finally sort or deduplicate the text to get the final result; in the BlueKing Job Platform, you can easily achieve the goal through the built-in function `job_succese`.

## Scene case

Here are a few examples of actual demand scenarios to demonstrate:

### 1. Check all machines for duplicate hostnames

- code logic

   ![image-20200504182752953](media/image-20200504182752953.png)

- Result display

   ![image-20200504183245205](media/image-20200504183245205.png)

   In the above figure, we will find that the `job_success` method will display the same hostname execution results in groups in turn; in the red box, it can be seen that each group has only one host, so the conclusion is that there is no **hostname duplication** question.

### 2. Check the memory distribution of the online machine

- code logic

   ![image-20200504184143563](media/image-20200504184143563.png)

- Result display

   ![image-20200504184308400](media/image-20200504184308400.png)

   As shown in the figure above, the memory distribution of the final 4 machines has three types: `16G`, `32G` and `64G` respectively; among them, there are two machines with `32G` memory.

## In conclusion

There are still many scenarios of "displaying/statistics of information of multiple servers in groups" like this, so I won't list them one by one here;

I hope the above examples can help you understand how to use the built-in functions of the BlueKing platform. Thank you for your support.