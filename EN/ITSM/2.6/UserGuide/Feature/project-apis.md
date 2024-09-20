 ## API Manage 

 When you need to reference a third-party system for auto processing in the Flow, or need to reference some Data in the third-party system as necessary information in the process, you can Manage the interface of the third-party system approve the API setting function.  complete Configure, you can directly reference these APIs during Flow Node Set. 

 [ITSM] has built-in system APIs of some BlueKing systems, which can be accessed or maintained as needed. 

 > The API setting Module has a certain threshold, and the Administrator needs to have a full understanding of the call protocol between APIs. 

 1. new API 

   You need to connect to the system before new an API.  After accessing the system, you can append APIs to The system. 
   ![1689078310597](image/project-apis/1689078310597.png) 
   ![1689078355992](image/project-apis/1689078355992.png) 
   ![1689078392087](image/project-apis/1689078392087.png) 
   <center>API setting</center> 

 2. API Usage 

 - API Node 

  When designing the Flow, you can directly Choose the appropriate API approve dragging the API Node.  After selected, the corresponding Field Parameter link Set is approve. After the Flow Apply, when the Ticket flows to The Node, the corresponding API is auto called for processing and circulation. 

 ![1689078525610](image/project-apis/1689078525610.png) 

 <center>append API node</center> 

 ![1689078488900](image/project-apis/1689078488900.png) 

 <center>API Node Configuration</center> 

 - API field 

  When Manage the Flow bill of lading Field, if the field value needs to be called or referenced from a third-party system, the Source can be set to be obtained from API when Set The field value. 

 ![1689078658505](image/project-apis/1689078658505.png) 
 ![1689078689410](image/project-apis/1689078689410.png) 

 <center>API Field configuration List</center> 