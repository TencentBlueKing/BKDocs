 # Model Relationships 

 In real CMDB Manage, relationships naturally exist between data.  The model Relationships feature definition how models are link to each other. 

 ![1579054176310](../media/1579054176310.png) 
 <center>Figure 1. model relationship view</center> 

 ## Base view Operation 

 Enter the model Relationship function, and all models and relationship setting diagrams of the current CMDB will be Display by default. click the group list on the left to quickly focus on the models under the current grouping. 

 ![1579057199154](../media/1579057199154.png) 
 <center>Figure 2. Switching to group view</center> 

 click the Hide button behind the model or model group to hide some models that are not Starred. 

 ![1579057316494](../media/1579057316494.png) 
 <center>Figure 3. Hide model group</center> 

 ## Add a model Relationship 

 Enter the "model Relationship" function, click "edit Topology" to enter the editing mode. At this time, hover over the model and the function of create relationship will appear. After selecting One model, the dialog box of creating association will appear.  You can create One set of model associations by select the appropriate link type and constraint method.  The relevant description is as follows: 

 - Source model-target model: The relationship between models has a direction attribute, which is distinguished by the arrow direction in the view.  By default, the pointer points from the source model to the target model.  You can also adjust the pointing in the link type 
 - link Type: system comes with several common association types, such as "Belonging","Composition","Run","Uplink" and "Default". 
 - target constraint: The default is N-N. One source instance can be link multiple target instances, and any target instance can also be associated with multiple source instances.  The 1-N constraint means that One source instance can be link any number of target instances, but if a target instance has been associated with a source, it cannot be associated with Other source instance.  1-1 The constraint means that One source instance can only be link one target instance, and a target instance can only be associated with one source instance 
 - link description: An aliasName for the current relationship for user Identify 

 ![1579056952798](../media/1579056952798.png) 
 <center>Figure 4. edit mode</center> 

 ![1579057463124](../media/1579057463124.png) 
 <center>Figure 5. Visually create link</center> 

 ![1579058241668](../media/1579058241668.png) 
 <center>Figure 6. add link Confirm</center> 

 ## Delete model Relationship 

 In the edit mode, click the link relationship again to view or delete the current association. 

 It should be noted that, in order to protect the Base functions of the system, some built-in link cannot be delete or Revise. 

 ## Create Relationships in manage 

 When the Quantity of model is too large and the view is not convenient for Operation, you can find the corresponding model in "manage" and switch to the Model Relationship label create an link. 

 ![1579058537897](../media/1579058537897.png) 
 <center>Figure 7. add link Confirm</center> 