# Permission Template

Create an Auth Template for a Super Administrator ([How to Become a Super Admin](../ProductFeatures/Manager.md), [How to Become an Administrator](../ProductFeatures/Manager.md), [How to Become a Grading Manager](../ProductFeatures/GradingManager.md)).

## Precondition 

> 1. The user must be a Grading Administrator/Super Administrator/System Administrator.

Permission templates are mainly used for **Reusability**. Grading administrator can create a permission template to link authorization with multiple UserGroups. After the permission template is updated, it can be synchronized with the UserGroups with associated authorization. 

## Add an Permission Template

Enter the **Permission Management** page, switch to the **Permission Template** menu, and click **Add** to create a new template. One template can only include the operation permission of **One system**.

![image-20220921164200733](PermissionTemplates/image-20220921164200733.png)

## Editing Permission Template

On the **Permission Template** page, select the permission template to be edited, click **Permission Template Name** to enter the details page of the permission template, and click Edit in the details page to edit the template. 

![image-20220921164348799](PermissionTemplates/image-20220921164348799.png)

If the Permission Template is not associated with any UserGroup, it can be saved directly after editing and updating.
If a UserGroup has been associated, click **Next** to synchronize the UserGroups, and select the resource instances required by the operations added to the template in each UserGroup. BKIAM provides two ways to batch refresh instances. 

**Batch Paste**: Select the instances in a UserGroup, and then click **Copy** at the end of the input box. After the copy is successful, the **Batch Paste** icon will pop up. Click Batch Paste to swipe the corresponding instances to other UserGroups. 

**Batch reference resource instances for existing operations**: This feature is used when **Different instances are selected for the same operation in different UserGroups**. For example, when **Business access** corresponds to different instances in 100 UserGroups, batch pasting or manual selection is not feasible. 

This can be done by Batch referencing resource instances of existing operations. Click this button in the upper right corner of the input box, select an existing operation in the template, and then automatically batch populate it to each UserGroup.

![image-20220921164554362](PermissionTemplates/image-20220921164554362.png)