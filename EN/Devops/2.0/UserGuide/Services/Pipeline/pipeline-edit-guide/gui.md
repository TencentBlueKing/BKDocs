 #Graphical Pipeline Orchestration 

 ## Stage Operation Collection 

 ### Enable allowEnter for Stage 

 In the full CI/CD lifecycle, we will inevitably have some step where we expect human intervention, and the Stage allowEnter feature allows you to pause the flow before the pipeline runs to a certain Stage, and then resume after human intervention. 

 #### Enable Method 

 When editing the pipeline, click the lightning icon in the upper left corner of an existing Stage click Enter the Stage allowEnter Properties Panel 

 ![](../../../assets/image%20(50).png) 

 ![](../../../assets/image%20(49).png) 

 #### Effect after activation 

 * If a buildTask is in the allowEnter toCheck stage, it will be in the "STAGE\_SUCCESS" state. See [Summary of Pipeline Status Information](../pipeline-build-detail/status.md#pipeline-zhuang-tai) for more information. 