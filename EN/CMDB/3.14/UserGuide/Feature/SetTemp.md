 # Set Template 

 The cluster Template can definition the general cluster structure of the Business, which is used for [Business Topology](./  BusinessTopology.md).  This function depends on the existing [Service Template](./  ServiceTemp.md)。 

 ## Create a Set Template 

 Enter "Set Template", and click "create" to create a add cluster template. 

 ![image-20220923205415153](media/image-20220923205415153.png) 
 <center>Figure 1: Start Set Template</center> 

 The cluster Template consists of Three pieces of information: 

 - basicInfo 

  - Template name 

    The ID of the Set template, which can be Identify when using. 

 - attribute Set 

  The attribute Field Settings of the Set can be setting to the template. When Generate cluster instances, they can be rendered at the same time for subsequent unified management Manage 

 - Set topology 

  Used to design which module The Set is composed of, and how modules are Generate is governed by their templates 

 ![image-20220923205912840](media/image-20220923205912840.png) 
 <center>Figure 2: Set Template edit Status</center> 

 ![image-20220923210058510](media/image-20220923210058510.png) 
 <center>Figure 3: view the list of link instances Generate by the cluster Template</center> 

 ## Using Set Template 

 Enter "Business Topology". When create a Set, select Create from Template and add the cluster name. 

 ![image-20220923210218867](media/image-20220923210218867.png) 
 <center>Figure 4: create a cluster using a cluster Template</center> 

 After the Business is created, you can see that the topology containing module has been created under the service. user can directly assign Host to the topology. 

 ![image-20220923210457208](media/image-20220923210457208.png) 
 <center>Figure 5: complete the create Set</center> 

 ## Synchronization 

 After the structure of the Set template changed, it can be updated to the cluster instance in batches approve the synchronization feature. 

 Note that Operation performed asynchronously, so try not to make changes to the Current cluster before synchronization is complete. 

 ![image-20220923210630604](media/image-20220923210630604.png) 
 <center>Figure 6: Revise the Set template Success</center> 

 ![image-20220923210742836](media/image-20220923210742836.png) 
 <center>Figure 7: Synchronization Set Template</center> 

 ![image-20220923210803772](media/image-20220923210803772.png) 
 <center>Figure 8: Synchronization Set Template Confirm</center> 

 ## Delete 

 To ensure the Safety and accuracy of the setting, the hasExisted link clusters need to be cleared before delete the Set template. 