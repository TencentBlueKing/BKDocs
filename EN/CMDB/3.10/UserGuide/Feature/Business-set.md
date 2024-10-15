 # Business Name Set 

 "Business Name set" is a resources space composed of One or more services, and it has a direct relationship with services. Common Manage Scene are mostly public platform functional teams, such as Database OPS team, middleware OPS team, Base OPS team, etc.; These functional teams are Manage Scene above the Business Name layer, and consume Host in businesses that Meets The attribute conditions across business Dimension approve "business sets". 

 ## Model 

 ![image-20220406105257031](media/image-20220406105257031.png) 

 page path: `model` - `manage` - `Business Name Set` 

 "Business Name Set" is a built-in model and is in the model group of `Host Manage` by default. After initialization, there are Three field: `Business Name Set Name` `Business Set description` and `OPS Personnel`. user can append corresponding Field configuration in The model as needed. 

 ## Model Instance 

 ![wecom-temp-d0a4ff5e2887fb339dce0a450312ae97](media/wecom-temp-d0a4ff5e2887fb339dce0a450312ae97.png) 

 page path: `resources` - `Business Name Set` 

 - Business Name set name 

  name of the Business Name set 

 - Business Name Set description 

  It is used to Fill In the information describing the background and purpose of the Business Name set 

 - Operation and maintenance personnel 

  List of personnel responsible for operation and maintenance of The Business Name set 
  
 - Business Name Scope 

  The business scope included in The Business Name set. All by default (dynamic, i.e., all the newly new businesses will be included) 
	
  You can also manual check the list of specified Business Name (multiple choices) 
	
  ![image-20220406110242420](media/image-20220406110242420.png) 
	
  Or it can be obtained dynamic by approve the conditions of the `Organization` and `Enumeration` Field of the Business Name 
	
  ![image-20220406110341735](media/image-20220406110341735.png) 
	
 - pipelinesPreview 

  During the create process or list, you can approve `pipelinesPreview` to view the list of businesses included in a Business Name set, as follows: 
  ![image-20220406110546002](media/image-20220406110546002.png) 



 ## Manage Spaces 

 ![image-20220406111016891](media/image-20220406111016891.png) 

 page path: `Business Name` - `select Business/Business Set` 

 "Business Name Set" and business are also under the One Navigation of "Business", provided the same topology and Host view capabilities as business (but not edit); 

 - Business Name set topology 

  provided the topology Collection of the services included in the Business Name set, and can view the Host and service instances under All or each topology node 

 - Other 

  In addition, the Business Name set also provided the same Manage space as the business in the Job System. user can enjoy the same ability to control more Host across businesses under the business set. 