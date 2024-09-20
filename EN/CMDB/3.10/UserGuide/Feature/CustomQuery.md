 # DynamicGroup 

 dynamicGroup can set One aggregation group for resources of the same type to facilitate general in different Scene. for example all Host maintained by admin can be dynamically grouped to help userManage this aggregation according to Query Condition. When the number of Meets The resources increases or decreased, the query result of dynamic grouping will also change dynamically.  At present, dynamicGroup can be used in Job System, Standard OPS system, etc. 

 ## Group management 

 Enter the "Business Name-dynamicGroup" function to view current dynamic grouping list.  You can pipelinesPreview, edit delete hasExisted group. 

 ![1579160010918](../media/1579160010918.png) 
 <center>Figure 1. dynamicGroup</center> 

 ## Add a dynamicGroup 

 click "new" to add One dynamicGroup."groupName" is convenient to quickly Identify the purpose of the group."Query Condition" refers to which attributes of the Set, module or Host need to be queried. 

 Flexible Query Condition make it easy to setting dynamicGroup queries for Scene such for example "all Linux Host" and "all hosts managed by admin". 

 ![image-20220923212913940](media/image-20220923212913940.png) 
 <center>Figure 2. add dynamicGroup</center> 

 ## Add Set dynamicGroup 

 click new dynamicGroup and switch the Query Object to "Set" to create One dynamic group with "Cluster" as the query target. 

 ![image-20220923213007123](media/image-20220923213007123.png) 

 ## PipelinesPreview dynamicGroup result 

 ![image-20220923213118609](media/image-20220923213118609.png) 

 ![image-20220923213201626](media/image-20220923213201626.png) 