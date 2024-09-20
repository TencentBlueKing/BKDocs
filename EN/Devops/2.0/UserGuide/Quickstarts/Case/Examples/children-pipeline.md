 # subPipeline 

 subPipeline: You can call other pipelines under the current pipeline 

 * add Stage 

 ![](../../../assets/image-20211218153126542.png) 

 * select call pipeline Plugin. Here, the subPipeline be called “cdn" and belong to project "alltest". At the same time, it is divided into synchronous and asynchronous call execute. Fill In the var parameters of the sub-pipeline. 

 ![](../../../assets/image-20211218153213103.png) 

 ![](../../../assets/image-20211218161418247.png) 

 * append runscript Plugin, sleep for 20s 

 ![](../../../assets/image-20211218161316700.png) 

 * subPipeline demo, execute the Operation of sleep 10 

 ![](../../../assets/image-20211218161541806.png) 

 * execute Pipeline. The call pipeline will Success Immediately after calling the subPipeline, and then execute the next Operation. At this time, the sub-pipeline demo will be executed asynchronously (in the case of synchronization, it will wait for the Pipeline runs complete the execution before executing the next One) 

 ![](../../../assets/image-20211218161727205.png) 

 ![](../../../assets/image-20220301101202-Azved.png) 