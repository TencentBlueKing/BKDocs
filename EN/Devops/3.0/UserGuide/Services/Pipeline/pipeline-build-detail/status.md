 # Summary of Pipeline status information 

 ## Pipeline status 

 | KEY | Description | Display Name | 
 | :--- | :--- | :--- | 
 | QUEUE |Initial Status: waiting for Schedule in the Queue, and switching to QUEUE\_CACHE before preparing for execute| In Queue| 
 | QUEUE\_CACHE |Intermediate Status: Enter execute Queue, can Start Up| execute| 
 | RUNNING |Intermediate Status: running| running| 
 | CANCELED |Final Status: cancel| cancel| 
 | STAGE\_SUCCESS |Final status: One Success status when the Stage manual toCheck is cancel| stageSuccess (Success)| 
 | SUCCEED |Final Status: Success| Success| 
 | FAILED |Final Status: failed| failed| 
 | TERMINATE |Final status: Pipeline in RUNNING status is forcibly terminate due to environment abnormal| terminate (failed)| 
 | QUEUE\_TIMEOUT |Final state: Timeout caused by waiting for Schedule in Queue| QUEUE_TIMEOUT| 

 ## Stage status 

 | KEY | Description | Display Name | 
 | :--- | :--- | :--- | 
 | QUEUE |Initial Status: waiting for Schedule in the Queue, and switching to QUEUE\_CACHE before preparing for execute| In Queue| 
 | QUEUE\_CACHE |Intermediate Status: Enter execute Queue, can Start Up| execute| 
 | RUNNING |Intermediate Status: running| running| 
 | REVIEWING |Intermediate Status: stage is under manual REVIEWING| REVIEWING| 
 | PAUSE |Intermediate Status: when Stage manual toCheck waitForApproval| PAUSE execute| 
 | CANCELED |Final Status: cancel| cancel| 
 | SUCCEED |Final Status: Success| Success| 
 | FAILED |Final Status: failed| failed| 
 | TERMINATE |Final state: Stage in RUNNING status is forcibly terminate due to environment abnormal| terminate (failed)| 
 | SKIP |Final Status: SKIP Not execute| SKIP| 
 | UNEXEC |Final status: UNEXEC, may end due to buildFail, and not executed later| UNEXEC (does not participate in the final Success/failed status calculation)| 
 | QUEUE\_TIMEOUT |Final state: Timeout caused by waiting for Schedule in Queue| QUEUE_TIMEOUT| 
 | STAGE\_SUCCESS |Final status: One Success status when the Stage manual toCheck is cancel| stageSuccess (Success)| 

 ## Job status 

 | KEY | Description | Display Name | 
 | :--- | :--- | :--- | 
 | QUEUE |Initial Status: waiting for Schedule in the Queue, and switching to QUEUE\_CACHE before preparing for execute| In Queue| 
 | QUEUE\_CACHE |Intermediate Status: Enter execute Queue, can Start Up| execute| 
 | LOOP\_WAITING |Intermediate Status: LOOP_Waiting exclusive group lock| Mutex round LOOP_Waiting| 
 | DEPENDENT\_WAITING |Intermediate Status: wait for the dependent job to complete before Enter the preparation environment| dependent wait| 
 | PREPARE\_ENV |Intermediate Status: In the preparation environment, the agent Activating| in that prepare environment| 
 | RUNNING |Intermediate Status: running| running| 
 | PAUSE |Intermediate Status: When the Plugin PAUSE execute, the status of the Job is also Set to suspended| PAUSE execute| 
 | CANCELED |Final Status: cancel| cancel| 
 | SUCCEED |Final Status: Success| Success| 
 | FAILED |Final Status: failed| failed| 
 | TERMINATE |Final status: JOB in RUNNING status is forcibly terminate due to environment abnormal| terminate (failed)| 
 | SKIP |Final Status: SKIP Not execute| SKIP| 
 | UNEXEC |Final status: UNEXEC, may end due to buildFail, and not executed later| UNEXEC (does not participate in the final Success/failed status calculation)| 
 | QUEUE\_TIMEOUT |Final state: Timeout caused by waiting for Schedule in Queue| QUEUE_TIMEOUT| 
 | HEARTBEAT\_TIMEOUT |Final status: During the build process, the Agent loss with the service for more than 2 minutes| HEARTBEAT_TIMEOUT (failed)| 

 ## Task status 

 | KEY | Description | Display Name | 
 | :--- | :--- | :--- | 
 | QUEUE |Initial Status: waiting for Schedule in the Queue, and switching to QUEUE\_CACHE before preparing for execute| In Queue| 
 | QUEUE\_CACHE |Intermediate Status: Enter execute Queue, can Start Up| execute| 
 | RETRY |Intermediate Status: failed retry is Set and Enter execute Queue| To be retry| 
 | RUNNING |Intermediate Status: running| running| 
 | CALL\_WAITING |Intermediate Status: used to Start Up the buildEnvType Plugin wait for the agent to call back the startup result| Wait for agent callback (running)| 
 | REVIEWING |Intermediate Status: manual toCheck Plugin or Gate is setting manual review and is pending review| To be toCheck (running)| 
 | PAUSE |Intermediate Status: the Plugin has Set execute PAUSE| PAUSE execute| 
 | REVIEW\_ABORT |Final status: manual toCheck Plugin or Gate is setting manual review and abort/terminate is clicked| Manual REVIEW_ABORT (failed)| 
 | REVIEW\_PROCESSED |Final status: manual toCheck Plugin or Gate has been setting manual review and approve| Manual REVIEW_PROCESSED (Success)| 
 | CANCELED |Final Status: cancel| cancel| 
 | SUCCEED |Final Status: Success| Success| 
 | FAILED |Final Status: failed| failed| 
 | TERMINATE |Final status: The Plugin in RUNNING status is forcibly terminate due to an environment abnormal| terminate (failed)| 
 | SKIP |Final Status: SKIP Not execute| SKIP| 
 | EXEC\_TIMEOUT |Final status: lastExecTime exceeds the setting Timeout| EXEC_TIMEOUT (failed)| 
 | UNEXEC |Final status: UNEXEC, may end due to buildFail, and not executed later| UNEXEC (does not participate in the final Success/failed status calculation)| 
 | QUEUE\_TIMEOUT |Final state: Timeout caused by waiting for Schedule in Queue| QUEUE_TIMEOUT| 
 | QUALITY\_CHECK\_FAIL |Final status: failed directly after being intercepted by Gate (manual toCheck is Not Set)| Blocked by Gate (failed)| 