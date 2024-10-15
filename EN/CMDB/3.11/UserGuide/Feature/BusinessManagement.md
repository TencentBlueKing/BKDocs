 # Business Manage 

 Business is an important concept in BlueKing CD system. In daily use, the Manage of Host, process and business topology depends on existing business. 

 ![1579072866404](../media/1579072866404.png) 
 <center>Figure 1. Business Manage</center> 

 ## Create a New Business

 When there is a big difference in topology, Manage mode, Deploy gateway or management personnel, it is recommended to create One new Business to isolate the use and auth of related resources. 

 Explanation of some key attributes of add Business: 

 - Business Name: The name used to Identify the business 
 - Life Cycle: Used to identify the operation Stage of the current Business. 
 - Time zone: BlueKing supports cross-border control and setting Business correct time zone for Observations and data mining scenarios. 
 - Language: In SaaS Scene, notifications are sent in different languages depending on setting 
 - OPS personnel: In the CD Scene, OPS is usually considered as the Manage of the Business, so OPS is isRequired in the business 

 ![1579073496488](../media/1579073496488.png) 
 <center>Figure 2. add Business</center> 

 ## BlueKing Business 

 After BlueKing is built, the "BlueKing" Business will be auto create, and Blueking‘s own module and process Distribution will be initialized. This business can be used for monitoring, Shrinkage capacity other Operation, and cannot be delete. 