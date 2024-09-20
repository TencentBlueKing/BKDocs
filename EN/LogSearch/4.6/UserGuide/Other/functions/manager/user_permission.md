# User Management

User management is mainly to solve the problem of user permissions. Permissions need to be set when setting up collection, index sets, etc.

## How to apply for permission

1. First apply for permission to configure a certain business on the platform (at least viewing permission is required)
2. Join a character. (Supported roles: Operation and maintenance personnel Developers Product personnel)
     * If you have the business permission to configure the platform, edit the role in the business and add it to a certain role
     * If you do not have platform business permissions, ask the administrator to add them.
3. If you want to troubleshoot errors and view job execution history, you need to apply for all viewing permissions for the execution history of the job platform.
4. If you want to create a new user group, use the `user group` creation function

## User group creation

The three user groups of operation and maintenance personnel, developers, and product personnel are the default groups. Members of the default group are synchronized from the CMDB and do not support modification.

Administrators can create new user groups to support more diverse usage scenarios.

When a new user is added to a user group, the new user automatically obtains all the permissions corresponding to the user group.

![-w2020](../../media/2019-12-12-10-00-42.jpg)