 # Pipeline edit Page 

 One of the core page of Pipeline, CI pipeline can be Generate approve visual interface. 

 ## Introduction to Function Area 

 ![png](../../../assets/service_pipeline_edit.png) 

 1. Pipeline Breadcrumbs: There are two click event Here 
   - click pipelineName to quickly Enter the Pipeline pipelinesHistory 
   - click the triangle to the Right of the name: Quickly switch to another Pipeline 
 2. Pipeline edit label allows you to switch between the pipeline layout page and the baseSetting: 
   - Pipeline area: refer to point 3 
   - Pipeline baseSetting: 
 3. Pipeline layout area: comply with [Pipeline Core Concept](../../Concepts/Learn-pipeline-in-5min.md) 
 4. Pipeline Operation area contains the following Starred operation Collection: 
   - save: Each time you click Save, a pipelineVersion will be Generate, which will increment from 1, and can be used for Rollback 
   - execute: Generate One snapshot Pipeline Task based on the current pipelineVersion 
   - rename: rename the current pipelineName 
   - toCollect: Collect the current Pipeline, which can be view in the "collection" view 
   - exportPipelineJson: Export the current Pipeline as JSON, which can be import when addPipeline (across different project) 
   - copy as: Copy One new pipeline "old pipelineName_copy" based on the current pipelineVersion of the current Pipeline 
   - saveAsTemplate: save the current Pipeline layout as a pipeline template 
   - delete: soft delete, will be put into Pipeline recycleBin 

 ## Next you may need 

 * orchestration Pipeline 
   * basic Operation 
      * [Stage allowEnter](pipeline-edit-guide/gui.md) 
      * [enable customize buildNo for Pipeline](pipeline-edit-guide/alias-buildno.md) 
      * [Lock Pipeline](pipeline-edit-guide/disable-pipeline.md) 
   * Triggers 
      * [gitlab triggers](pipeline-triggers/pipeline-trigger-gitlab.md) 
      * [Manual triggers](pipeline-triggers/pipeline-trigger-manual.md) 
      * [Scheduled triggers](pipeline-triggers/pipeline-trigger-timer.md) 
      * [Remote triggers](/pipeline-triggers/pipeline-trigger-remote.md) 
   * pipelineVar 
      * [Basic Usage of var](pipeline-variables/pipeline-variables-shell-batch.md) 
      * [Using var to Control Pipeline Flow](pipeline-variables/pipeline-variables-flow-control.md) 
      * [Use remark var](pipeline-variables/pipeline-variables-remark.md) 
      * [Voucher var](pipeline-variables/pipeline-variables-ticket.md) 
 * [BK-CI Navigation bar](../Console.md) 
 * [Pipeline List Page](pipeline-list.md) 
 * [Pipeline Task History](pipeline-history.md) 
 * [Pipeline Details Page](../pipeline-build-detail/pipeline-detail.md) 