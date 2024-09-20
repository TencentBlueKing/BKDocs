 # Predefined Constants/var 

 The proper use of constants/var makes it easier to maintain Pipeline. BK-CI provided many system constants/variables. 

 Usage: In Plugin Config, Input `${{Name}}` to get the value of the corresponding variable.  For example,`${{BK_CI_PIPELINE_NAME}}` 


 ## Predefined Constants 

 > For historical reasons, some constants are not Overwrite, but it is not recommended to Revise the value of the constant. 

 | Variable | Description |Sample| 
 | :--- | :--- | :--- | 
 | BK\_CI\_PIPELINE\_ID |pipelineId, 34-bit length, globally unique|  p-2fc5a05b25024d5586742b8e88d3c853 | 
 | BK\_CI\_START\_TYPE |build Start Up method. The Access in MANUAL/TIME\_TRIGGER/WEB\_HOOK/SERVICE/PIPELINE/REMOTE|  WEB\_HOOK | 
 | BK\_CI\_PROJECT\_NAME |projectId|  alltest | 
 | BK\_CI\_PIPELINE\_NAME |pipelineName| Continuous delivery Pipeline| 
 | BK\_CI\_BUILD\_ID |Pipeline current build ID, 34 bits length, globally unique|  b-d82918fc4f5c44c790d538785685f36b | 
 | BK\_CI\_BUILD\_NUM |build No., starting from 1 and increasing continuously|| 
 | BK\_CI\_BUILD\_JOB\_ID |The current Job ID of the current Pipeline build, 34 bits in length, globally unique|| 
 | BK\_CI\_BUILD\_TASK\_ID |The current Plugin Task ID of Pipeline, 34 bits in length, globally unique|| 
 | BK\_CI\_BUILD\_REMARK |Pipeline build remark information, Set approve setEnv "BK\_CI\_BUILD\_REMARK" when pipeline is running|| 
 | BK\_CI\_BUILD\_START\_TIME |Pipeline Start Time, ms|| 
 | BK\_CI\_BUILD\_END\_TIME |Pipeline End Time, ms|| 
 | BK\_CI\_BUILD\_TOTAL\_TIME |Pipeline executionTime|| 
 | BK\_CI\_BUILD\_FAIL\_TASKS |all TASK failed in Pipeline runs, content format: 1. Format: \[STAGE aliasName\]\[JOB alias\]TASK alias 2. If multiple concurrent JOBs failed, use newline\nseparation| Can be used in buildFail notifications, or in Plugin during Pipeline runs| 
 | BK\_CI\_BUILD\_FAIL\_TASKNAMES |all TASK failed in Pipeline runs, content format: TASK aliasName,TASK alias,TASK alias| Can be used in buildFail notifications, or in Plugin during Pipeline runs| 
 | BK\_CI\_TURBO\_ID |Turbo Task ID The variable is available only when compilation acceleration is Enable.|| 
 | BK\_CI\_MAJOR\_VERSION |Unique in Pipeline, the versionNum. Appears when the "recommendVersion" function is enabled|| 
 | BK\_CI\_MINOR\_VERSION |Unique in Pipeline, minorVersion. Appears when the "recommendVersion" function is enabled|| 
 | BK\_CI\_FIX\_VERSION |Only in Pipeline, fixVersion, appears after the "recommendVersion" function is enabled|| 
 | BK\_CI\_BUILD\_NO |It is unique in Pipeline. It is the buildNo. It appears when the "recommendVersion" function is enable. You can Set different auto-increment rules.|| 
 | BK\_CI\_PIPELINE\_UPDATE\_USER |Pipeline Update user|| 
 | BK\_CI\_PIPELINE\_VERSION |Pipeline versionNum|| 
 | BK\_CI\_PROJECT\_NAME\_CN |projectName corresponding Pipeline|| 
 | BK\_CI\_START\_CHANNEL |Pipeline start CHANNEL code|| 
 | BK\_CI\_START\_USER\_ID |The user ID of the actual execute of the Pipeline build, the current user ID when manual Start Up, and the user ID of the retry pipeline person.  lastUpdater by pipeline if timed/webhook/subPipeline call|| 
 | BK\_CI\_START\_USER\_NAME |The user ID of the Pipeline build Start Up, which is usually the same as BK\_CI\_START\_USER\_ID, except for the following two cases: 1. When the Start Up mode is WEBHOOK, The value is the user ID of Git/SVN; 2. In case of a subPipeline call, The value is the build Start Up ID of the parent pipeline| for example, the last Revise of parent1 and Sub2 is User0. user1 manually execute parent Pipeline of parent1, and then parent1 Start Up subPipeline Sub2, and at this time, BK\_CI\_START\_USER\_ID of Sub2 is User0; BK\_CI\_START\_USER\_NAME is User1| 
 | BK\_CI\_PARENT\_PIPELINE\_ID |Gets the ID of the parent pipeline that Start Up the current Pipeline, valid only when triggered by the parent pipeline as a subPipeline|| 
 | BK\_CI\_PARENT\_BUILD\_ID |Gets the build ID of the parent pipeline that Start Up the current Pipeline, valid only if triggered by the parent pipeline as a subPipeline|| 
 | BK\_CI\_START\_PIPELINE\_USER\_ID |Gets the parent pipeline initiator who Start Up the current Pipeline. Valid only when triggered by the parent pipeline as a subPipeline|| 
 | BK\_CI\_START\_WEBHOOK\_USER\_ID |Gets the triggering Webhook account that Start Up the current Pipeline. It is only valid when triggered by webhook. The value will be displayed in the pipelinesHistory, but the actual executor is not him, but the last pipeline Revise.|| 
 | BK\_CI\_RETRY\_COUNT |The number of retry, which does not exist by default. The var will only appear when there is a failed retry/rebuild, and +1|  
 | BK_CI_ATOM_VERSION| current Plugin versionNum, such as 1.0.1||  
 | BK_CI_ATOM_CODE| current Plugin ID|| 
 | BK_CI_TASK_NAME| Current step aliasName|| 
 | BK_CI_ATOM_NAME| current Plugin name|| 
 | | | | 


 In addition to the constants in the above Table, there are also constants that are relevant to the Code Repository: 

 - [git constant collection](./  git.md) 
 - [github constant collection](./  github.md) 


 ## Predefined var 

 > You can Set pipeline remark during Pipeline Run 

 | Variable | Description |Sample| 
 | :--- | :--- | :--- | 
 | BK\_CI\_BUILD\_REMARK |Pipeline build remark information, Set approve setEnv "BK\_CI\_BUILD\_REMARK" when pipeline is running|| 