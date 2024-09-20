 # Service Template 

 A Service Template can be used to pre-define services general to a Business, and is used for Batch Deploy and change of service instances in a business topology.  It can also be simply understood as a module template in the Business Topology. 

 ## Create a service Template 

 Enter Service Template to view hasExisted current service templates.  click "add" Enter the new service template setting page. 

 ![image-20220923181831763](media/image-20220923181831763.png) 
 <center>Figure 1: service templateList</center> 

 The setting service template contains the following information: 

 - basicInfo 

  - Template name 

    The unique ID of a service template. The module create by approve the service template will use the same name of the template.  The naming method is recommended to use simple and understandable functional words, such as test_database, erp_db, etc. 

  - Service Classification 

    Indicates the service type to which this template belongs. The system provided some common service types, such for example mysql, apache, etc. user can also customize add Business Service Classification 

 - attribute Set 

  Set the module properties corresponding to the service. You can setting them in the template, so that you can perform unified rendering and Manage when Generate module instances approve the template 

 - service process 

  Processes are an important component of service.  The key attributes of a process mainly include a Process Name and a process aliasName. The process name is the Two name of the process, and the process alias is the readable name of the process.  For example, the actual Run Two name of apche is java. If Fill In java, the actual role of this process cannot be Identify in the surrounding system. Therefore, in this case, you can fill in the Process Name as java and the process aliasName as tomcat.  There are Other information in the service process, for example listening port, listening IP, etc., which can be Fill In according to the needs of the actual Scene 

 ![image-20220923181939434](media/image-20220923181939434.png) 
 <center>Figure 2: service Template edit Status</center> 

 ## Apply service Template 

 Enter "Business Topology" and create "Set" in the topology tree on the left. When creating "module" in "Cluster", you can see the hasExisted service template in the previous step. 

 ![image-20220923182437383](media/image-20220923182437383.png) 
 <center>Figure 4: service templateList</center> 

 After a module is create and a Host is moved to The module, the platform will auto Generate the service instance of each host according to the process information setting by the link Service Template. The specific Operation are as follows: 

 ![image-20220923182809040](media/image-20220923182809040.png) 
 <center>Figure 5: Adding a Host to a module</center> 

 ![image-20220923182656692](media/image-20220923182656692.png) 
 <center>Figure 5: service instance is auto create when Host is transferred in</center> 

 ## Template Synchronization 

 When the service template changed, you can approve the "synchronization" function to synchronize the changes to the service instance. 

 ![image-20220923183538824](media/image-20220923183538824.png) 

 ![image-20220923183614156](media/image-20220923183614156.png) 
 <center>Figure 6: view the module to which the service template has been applied</center> 

 ![image-20220923183717953](media/image-20220923183717953.png) 
 <center>Figure 7: Synchronizing service Instances and Confirm</center> 

 ## Delete Template 

 To ensure the Safety and accuracy of the setting, when delete a service template, it is Check whether there is a module link with it.  That is, you should Clear all instances to which the template is Apply before delete them. 