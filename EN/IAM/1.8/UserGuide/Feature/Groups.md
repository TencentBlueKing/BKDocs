# UserGroup 

Create UserGroup is an administrator's ability [How to become a Super Administrator](../ProductFeatures/Manager.md),[How to become a System Administration](../ProductFeatures/Manager.md),[How to become a Grading Administrator](../ProductFeatures/GradingManager.md). 

## Precondition 

> 1. The user must true a grading administrator/super administrator/system administration

UserGroup is a permission management method **recommended** by BlueKing IAM. A UserGroup can append permissions to **multiple systems**. 

This chapter focuses on the create of UserGroup, UserGroup Members, UserGroup Authority Management and other functions.

## Add a UserGroup 

Click **UserGroup-Add** button (if you haven't create a permission template yet, you can create one first). 

![image-20220921152400871](Groups/image-20220921152400871.png) 

![image-20220921152435936](Groups/image-20220921152435936.png) 

- UserGroup Name: `Required`. 

- Description: `Required`, which clearly will the functions of the UserGroup, so that administrator or users can identify them when applying. 

- Add group member: `(Not required)`. Group members include user and organizations. IAM provided two methods add member: organization architecture topology selection and fmanual input (manual input only supports user addition). Members can also be added directly by finding the corresponding UserGroup in the UserGroup list. 

![image-20200921170621290](Groups/image-20200921170621290.png) 

- Add group permission: `(Not required)`. Select permission template or customize permission. 

![image-20210411221237846](Groups/image-20210411221237846.png) 
  
After selecting a template or customize permission, you need to link of specific resources instance. Select a resource instance and click **submit** complete a UserGroup. 

![image-20220921152816440](Groups/image-20220921152816440.png)
  

## Edit UserGroup 

Edit a UserGroup involves changes of group basicInfo, UserGroup permission, and members.

![image-20220921152923981](Groups/image-20220921152923981.png) 

- Edit a UserGroup involves changes of group basicInfo, UserGroup permission, and members.

- Group member editing: UserGroup members can be deleted or added.

- Edit group permission: Switch to the **Group Permissions** Tab page to append or delete instance permissions.


## Delete a UserGroup 

In the UserGroup list, you can directly for a UserGroup. Deleting a UserGroup will remove the users and permissions in the group. Please operate with caution.

![image-20220921153034429](Groups/image-20220921153034429.png)