# Access Request

BKLog's permission application is connected to the IAM, so you need to apply for BKLog usage permission mainly through the IAM.

There are two specific ways to apply:

1. Create a user group with permissions, such as xx business operation and maintenance group. The administrator with permissions can add corresponding people or apply to join the group.

   ![image-20241031210305711](perm/image-20241031210305711.png)

2. To apply for custom permissions, you can enter directly in the IAM or enter through the log product guide.

   ![image-20241031210332927](perm/image-20241031210332927.png)

## Permission granularity

There are two basic divisions for viewing and management according to the functions provided by BKLog. The minimum granularity is down to the index set. Generally speaking, there are the following user scenarios:

* Log retrieval: such as operation and maintenance, development, testing, products, etc. Applicable to application viewing operations
* Log configurer: such as operation and maintenance. Suitable for application viewing + management operations

![image-20241031210413056](perm/image-20241031210413056.png)