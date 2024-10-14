 # Customizing Linux C/C++ Acceleration Plan 

 ## Step1 Access BK-CI and Enter service → Turbo in the Navigation bar 

 For the first time, Enter the following page, click Use Immediately to enter the protocol customization page: 

 ![](../../../assets/image%20%2863%29.png) 

 Enter the Plan List Manage when there is a scheme: 

 ![](../../../assets/image%20%2838%29.png) 

 ## Step2 Fill In Scheme Config 

 ![](../../../assets/image%20%2864%29.png) 

 Scheme Config include: 

 1. Scheme name: As the identification name, you can Fill In "xxx Personal acceleration","daily build acceleration","agent out-of-package acceleration", etc. 
 2. Acceleration Mode: select the acceleration mode to be create. Once created, the acceleration mode **cannot be Revise**. 
 3. Program Description: You can write some remark or instructions here. 
 4. Compilation environment: select the corresponding compilation environment according to your local environment. If it is not in the list, please contact the administrator **Quick Support**. 
 5. Enable ccache: Check whether to enable ccache as needed. If enabled, local ccache will be given priority, and distributed acceleration will be used for parts that do not hit. 
 6. Priority Schedule gateway: select the nearest area according to the local environment. 

 ## Step3 submit registration and get the exclusive plan ID 

 After click submit, One unique scheme ID will be Generate. This ID can also be queried in the "Acceleration Plan" → click the scheme name to Enter the detail page. 

 Scheme ID is the certificate for using acceleration, which contains your Stage, Basic Info, and auth information. **Please keep your protocol ID safe and do not share it with others.** 

 ![](../../../assets/image%20%2865%29.png) 