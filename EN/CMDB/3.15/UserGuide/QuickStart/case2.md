 # Host is transferred from Business Name module A to service module B 

 Specific step: 

 **Host allocated to service Business Name machine pool--CVM is transferred to resources pool--CVM is allocated to service B idle machine pool--CVM is allocated to service B** 

 ![guide2](../media/guide2.png) 

 > Note： 
 > The Business Name attribute change information of the Host will not be synchronized with the NodeMan. Therefore, uninstall the Agent of the CVM uninstall the node management before the CVM is transferred, and reinstall the Agent in the node management after the CVM is transferred. 

 ## 1. Assign from the Host under the Normal module to the idle CVM pool of the A Business Name 

 Navigate Enter the Business Name resources-Business Topology page. 

 view the Host under the A1 module of service A, check the CVMs to be transferred, click Transfer To at the top, Select Target module "Idle Module" in the dialog box, select the target module to be transferred in the dialog box, and select "Idle Machine" here.  Enter the next to Confirm the changed of the service instance, i.e. complete the transfer Operation 

 ![image-20201105103528565](../media/case2/image-20201105103528565.png) 

 ![image-20201105103603145](../media/case2/image-20201105103603145.png) 



 ## 2. Host Handover resources Pool 

 Navigation Enter the Business Name resources-Business Topology page 

 view the "idle machine" module of the Business Name, check the Host that has just been transferred, click "Transfer to" at the top, select "resources Pool" in the dialog box, and click "Confirm" to complete the transfer. 

 ![image-20201105103804867](../media/case2/image-20201105103804867.png) 

 ![image-20201105103834516](../media/case2/image-20201105103834516.png) 

 ## 3. The Host is allocated to the idle machine pool of the B Business Name 

 Enter to "resources-Host-Unassigned", select the host you just transferred to, and select "Assign to-Business Name Idle Machine". 

 ![image-20201105104649279](../media/case2/image-20201105104649279.png) 



 select the target Business Name to transfer to 

 ![image-20201105104834184](../media/case2/image-20201105104834184.png) 

 # Host Module Assigned to Business Name B by CVM 

 Enter the Business Name, find the Host under the idle machine, and transfer to the module to be allocated 

 ![image-20201105105048611](../media/case2/image-20201105105048611.png) 