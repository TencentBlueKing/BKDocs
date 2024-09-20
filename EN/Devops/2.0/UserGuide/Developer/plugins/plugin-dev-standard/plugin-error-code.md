 # Plugin Error Code Specification 

 ## General Requirements 

 * Developer Plugin need to subdivide the various Scene that lead to failure of Plugin execution, identify them with Error Code, and provide detailed description and solutions in Plugin log and instructions for user to quickly locate and solve problems. 
 * Developer plugin need to classify error that cause plugin to fail, and specify error type errorType to measure statistics. 

 ##Error type and error code 

 ### 1 Plugin error type (errorType) 

 Report allows the errorType field in the plugin result: 

 | Error Type Access Implication Detailed Description 
 | :--- | :--- | :--- | :--- | 
 | USER | 1 |USERError| The plugin parameter setting by the user in the pipeline is incorrect, or the user business name logic is incorrect. 
 | THIRD\_PARTY | 2 |thirdPartyError| Error in calling other platform APIs other than BK-CI, such as: thirdImg platform apiError, Job System interface error, Weaving Cloud upload API request failed, etc.| 
 | PLUGIN | 3 |pluginError (default)| Plugin execution logic error, which must be followed up and resolved by the Develop. Developer is required to subdivide PLUGIN Error into Other type|. 

 > Note: The Plugin SDK provides only 1-3 value passing enumeration. If the plugin result does not specify or specifies a value other than 1-3, the error type access is 3 (pluginError) 

 ### 2 Plugin error code (errorCode) 

 Report allows the errorCode field in the plugin result: 

 | Access| Implication| Detailed Description| 
 | :--- | :--- | :--- | 
 | 2199001 |Default Error Code| The default error code for the plugin, as specified by the BK-CI platform specification, will be used if the Develop Plugin does not specify an error code. 
 | Customize| Develop Plugin definition Error Code| Develop Plugin are definition according to the specifications used by their team/platform, and can be used for data measure of later plugins/builds. 

 > Note: Plugin Error Code help Develop definition complete and systematic error message to facilitate problem positioning and report generation. 