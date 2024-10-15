 # Pipeline Group 

 As the project develops, the amount of pipelines increases day by day. In order to allow you or the project members to easily find the required pipelines in a variety of pipelines, you can use pipelineGroup function to manage the pipelines by service classification. 

 By default, the left side of the Pipeline Home is divided into "personalViewList" and "projectViewList". 
 - Any personalViewList project can be created and is only visible to itself. 
 - projectViewList can be created only by ProjectManager, and will be visible to all project members after creation 


 ![png](../../../assets/pipeline_group.png) 


 ## AddPipelineGroup 

 Click on the plus sign in the image to add the PipelineGroup: 

 ![png](../../../assets/pipeline_group_create.png) 

 ## PipelineCountEdit Pipeline 

 ![png](../../../assets/pipeline_group_add_entry.png) 

 pipelineGroup is divided into two groupStrategies: "staticGroup" and "dynamicGroup 

 grouping: precise manual assignment of pipelines within a group 

 Grouping: Set pipelineName, creator, pipeline label and other conditions, the pipeline is dynamically grouped into a group; 

 ### Append pipeline to staticGroup 

 ![png](../../../assets/pipeline_group_add_pipeline.png) 


 ### Remove pipeline from staticGroup 

 ![png](../../../assets/pipeline_group_remove_pipeline.png) 


 ### Append/removeFrom Pipeline in dynamicGroup 

 ![png](../../../assets/pipeline_group_dynamic.png) 

 After revising the dynamicGroup conditions, if the pipeline in the original group does not meet the new conditions, it will be automatically removedFrom after saving: 

 ![png](../../../assets/pipeline_group_dynamic_remove.png) 


 ## PatchManage 

 Click on patchManage to open the Batch Operation page. 

 ![png](../../../assets/pipeline_group_batch.png) 

 ### PatchAddTo 

 ![png](../../../assets/pipeline_group_batch_to.png) 


 ### PatchDelete 

 ![png](../../../assets/pipeline_group_batch_del.png) 