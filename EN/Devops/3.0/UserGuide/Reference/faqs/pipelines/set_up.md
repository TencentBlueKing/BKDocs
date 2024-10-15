 ## Q1: How to perform QUEUE/mutual exclusion Operation between Pipeline 

 Refer to this The document for setting 

 [Pipeline Exclusion](https://docs.bkci.net/tutorials/scene/pipeline-exclusion-queue) 



 ## Q2: Pipeline waits for the execution result of Other pipelines 

 Problem background: There is pipeline A, which can be execute separately, and I have pipeline B, which will call A and wait for One result of A. How to do mutual exclusion? 

 a subPipeline function may be used. 

 Call the subPipeline using the call pipeline.  select **Synchronous execute** to trigger Continue Waiting for execution result. You can decide whether to continue after the result is available. 



 ## Q3: How to Display customize information on the Pipeline build history page 

 You can add a shell **Plugin** to Pipeline approve Set the value of the Global Variables `BK_CI_BUILD_REMARK` to implement the desired remark.  The Field will not be Display until the Pipeline is finished. 

 and a remark Field is append to the Pipeline history page.  Please refer to: 

 [Use remark var](https://docs.bkci.net/services/pipelines/pipeline-variables/pipeline-variables-remark) 



 ## Q4: Can var in Pipeline be linked? for example the value of variable B changes with variable A changed 

 Linkage is not supported for the time being. If the value does not changed, you can Set the defaultValue. 



 ## Q5: Can I get the Parameter drop-down list value approve a customize API during Pipeline runs? 

 Interface customize is not supported 



 ## Q6: Do multiple jobs share One workspace? 

 If you use a single (Self hosted agent) agent, multiple jobs will share One workspace directory. 

 In the case of a BK-CI hosted agent, each job will have One separate directory under workspace. 

 Self hosted agent and BK-CI hosted agent, by default each Pipeline creates One separate workspace directory. 



 ## Q7: How to get the URL of the build product 

 http://devops.bktencent.com/ms/artifactory/api/user/artifactories/file/download/local?  filePath=/bk-archive/${projectName}/${BK\_CI\_PIPELINE\_ID}/${BK\_CI\_BUILD\_ID}/{your artifacts fileName} 



 --- 