# Built-in Administrative Role

In order to facilitate administrator to manage permission, BKIAM has three built-in management roles: Super Administrator, System Administrator, Grading Administrator ([How to become Super Administrator](../ProductFeatures/Manager.md),[How to become a System Administrator](../ProductFeatures/Manager.md),[How to become a Grading Administrator](../ProductFeatures/GradingManager.md)). 

**Admin** is the only initial login account and the default super administrator.

**Super Administrator** and **System Administrator** are special Grading Administrators. 

- Super Administrator: By default, Admin has all the **authorization** permissions of the BlueKing platform (Admin has all the **authorization** and **operation** permissions on the BlueKing platform by default). You can set all the **operation** permissions. For more information, please see [Super Administrator setting](./Manager.md#super-administrator-setting). 

- System Administration: By default, the administrator has all **authorization** permissions of the corresponding system. You can set all **operation** permissions of the corresponding system. For more information, please see [System Administrator setting](./Manager.md#administrator-setting). 

- Grading Administrator: By default, the administrator has **authorization** permissions for all resources within the grading management range. Such as operation permission is required, self-authorization is required. For more information, please see [Grading Administrator](./GradingManager.md).

| Default Permissions | Super Administrator|System Administrator|Grading Administrator|
 | ------------------ | ---------- | ---------- | ---------- | 
 | Permission Template add       | ✓          | ✓          | ✓          | 
 | Permission Template edit       | ✓          | ✓          | ✓          | 
 | Permission Template view       | ✓          | ✓          | ✓          | 
 | Permission Template delete       | ✓          | ✓          | ✓          | 
 | Permission Template link UserGroup| ✓          | ✓          | ✓          | 
 | UserGroup add         | ✓          | ✓          | ✓          | 
 | UserGroup view         | ✓          | ✓          | ✓          | 
 | UserGroup delete         | ✓          | ✓          | ✓          | 
 | UserGroup Members     | ✓          | ✓          | ✓          | 
 | UserGroup Authority Management     | ✓          | ✓          | ✓          | 
 | Administrator Feature setting     | ✓          | ✓          |            | 
 | Approval process setting       | ✓          | ✓          | ✓          | 
 | Organizational architecture Authority Management   | ✓          |            |            | 
 | Grading Administrator add     | ✓          |            |            | 
 | Grading Administrator edit     | ✓          |            |            | 
 | Grading Administrator delete     | ✓          |            |            | 
 | Grading Administrator view     | ✓          |            |            | 
