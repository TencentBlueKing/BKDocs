 # python_atom_sdk API Guide 

 ## SDK Code Structure 
 ```text 
 python_atom_sdk 
 ├── __init__.py     # SDK Exposed Interfaces 
 ├── bklog.py        #log Related 
 ├── const.py        #Constants 
 ├── input.py        #Parsing user Input 
 ├── openapi.py      #Call the openapi interface 
 ├── output.py       #Set Output 
 ├── setting.py      #setting 
 ``` 
 Focus on `__init__.py`, where all the functions needed to Develop the Plugin are definition 

 ## \_\_init\_\_.py 
 ```python 
 # -*- coding: utf-8 -*- 

 from .bklog import BKLogger, getLogger 
 from .input import ParseParams 
 from .output import SetOutput 
 from .const import Status, OutputTemplateType, OutputFieldType, OutputReportType, OutputErrorType 

 log = BKLogger() 
 parseParamsObj = ParseParams() 
 params = parseParamsObj.get_input() 
 status = Status() 
 output_template_type = OutputTemplateType() 
 output_field_type = OutputFieldType() 
 output_report_type = OutputReportType() 
 output_error_type = OutputErrorType() 


 def get_input(): 
    """ 
    @summary: Get Plugin Input Parameters 
    @return dict 
    """ 
    return params 


 def get_project_name(): 
    """ 
    @summary: Get the projectId 
    """ 
    return params.get("project.name", None) 


 def get_project_name_cn(): 
    """ 
    @summary: Get alias of project 
    """ 
    return params.get("project.name.chinese", None) 


 def get_pipeline_id(): 
    """ 
    @summary: Get pipelineId 
    """ 
    return params.get("pipeline.id", None) 


 def get_pipeline_name(): 
    """ 
    @summary: Get pipelineName 
    """ 
    return params.get("pipeline.name", None) 


 def get_pipeline_build_id(): 
    """ 
    @summary: Get buildId 
    """ 
    return params.get("pipeline.build.id", None) 


 def get_pipeline_build_num(): 
    """ 
    @summary: Get buildno 
    """ 
    return params.get("pipeline.build.num", None) 


 def get_pipeline_start_type(): 
    """ 
    @summary: Get Pipeline Start Up type 
    """ 
    return params.get("pipeline.start.type", None) 


 def get_pipeline_start_user_id(): 
    """ 
    @summary: Get Pipeline Start Up 
    """ 
    return params.get("pipeline.start.user.id", None) 


 def get_pipeline_start_user_name(): 
    """ 
    @summary: Get Pipeline Start Up 
    """ 
    return params.get("pipeline.start.user.name", None) 


 def get_pipeline_creator(): 
    """ 
    @summary: Get Pipeline creator 
    """ 
    return params.get("BK_CI_PIPELINE_CREATE_USER", None) 


 def get_pipeline_modifier(): 
    """ 
    @summary: Get the Updated by of Pipeline 
    """ 
    return params.get("BK_CI_PIPELINE_UPDATE_USER", None) 


 def get_pipeline_time_start_mills(): 
    """ 
    @summary: Get Pipeline Start Time 
    """ 
    return params.get("pipeline.time.start", None) 


 def get_pipeline_version(): 
    """ 
    @summary: Get the version of Pipeline 
    """ 
    return params.get("pipeline.version", None) 


 def get_workspace(): 
    """ 
    @summary: Get workspace 
    """ 
    return params.get("bkWorkspace", None) 


 def get_test_version_flag(): 
    """ 
    @summary: whether the current Plugin is a Test version id 
    """ 
    return params.get("testVersionFlag", None) 


 def get_sensitive_conf(key): 
    """ 
    @summary: Get setting data 
    """ 
    conf_json = params.get("bkSensitiveConfInfo", None) 
    if conf_json: 
        return conf_json.get(key, None) 
    else: 
        return None 


 def set_output(output): 
    """ 
    @summary: Set Output 
    """ 
    setOutput = SetOutput() 
    setOutput.set_output(output) 


 def get_credential(credential_id): 
    from .openapi import OpenApi 
    client = OpenApi() 
    return client.get_credential(credential_id) 


 if __name__ == "__main__": 
    pass 
 ``` 

 Interfaces can be roughly divided into the following categories: 
 1. Get user Input.`get_input` Return One dictionary composed of `{"Input Component Name":"User Input content"}`. Call the method: `sdk.get_input().get("key")` 
 2. Set the user Input, and `set_output` sets the user Output. In command_line.py, it has been encapsulated as `exit_with_error` and `exit_with_succ`. 
 3. Get the Private setting, which is usually configured with Global Variables of the Plugin or account password information invisible to Normal user, such as BlueKing esb Gateway address, Request address of third-party service, etc. Call the method: `sdk.get_sensitive_conf(key)`, where key indicates the Configuration name, such as `sdk.get_sensitive_conf("BK_PAAS_URL")` 
 4. Get credentials.`get_credential` is the user's private setting. It can be configured approve credentialManage. The Plugin can get this information through `get_credential`. Call the method: `sdk.get_credential("credential_id")`, where credential_id is the English Name of the credential 
 5. Get Built-in variables. Except for the above 4 types, all Remaining APIs are used to get built-in variables. 
 6. There are also APIs log printing `sdk.log.info ("info") and sdk.log.error("error")`. 