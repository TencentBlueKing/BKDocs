 # Pipeline notification sent to nail 


 ## Keywords: Send Notification, Nail 

 ## Business Name Challenges 

 If the Pipeline notification is not received in time, in some Scene (such as: Task execute error), the user will not be able to obtain Pipeline runs "status" in time and make effective intervention 

 ## Advantages of BK-CI 

 BK-CI has new a nail notification Plugin that can send message notifications approve the form of group robots. 

 ## Solution 

 1. Add customize robots on the nail group Manage page. 

 ![&#x56FE;1](../../../assets/scene-notification-sent-nail-a.png) 

 2. It is Recommended to use the Security of "tagging". After the setting is complete, record the robot Webhook and tagging information. 

 ![&#x56FE;1](../../../assets/scene-notification-sent-nail-b.png) 

 3. Add the "nail message notification" Plugin in the BK-CI Pipeline layout. If not, please append in the BK-CI Market. 

 ![&#x56FE;1](../../../assets/scene-notification-sent-nail-c.png) 

 4. setting the Plugin information as follows: 

 ![&#x56FE;1](../../../assets/scene-notification-sent-nail-d.png) 

 5. Pipeline runs can see messages and 

 ![&#x56FE;1](../../../assets/scene-notification-sent-nail-e.png) 

 Note: 

 1. The message type supports Normal Text messages and MD information. 

 2. The function of @ Pipeline Start Up is only applicable to the case where the LDAP Account system has synchronous nail number for the time being. Other account systems are not adapted for the time being. If there are other customer requirements, it can be adapted. 