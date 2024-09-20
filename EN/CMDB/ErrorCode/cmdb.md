# CMDB Error Code 

 ## code description 

 1. The Error Code consists of 7 digits 
 2. The two bits from the left of the Error Code are fixed as 11, and the format is: 11XXXXX 
 3. The Three and Four digits from the left of the Error Code are used to indicate the code name of the process module 
 4. The Right Three digits of the Error Code indicate the error code within the specific process module 
 3. The left Four bits of common Error Code are fixed as 1199, format bit: 1199XXX 
 4. The Four bits on the left side of the API layer Error Code are fixed to 1100, and the format is: 1100XXX 
 5. The Four bits on the left side of the topo process Error are fixed to 1101, and the format is: 1101XXX 
 6. The left Four digits of the object process Error Code are fixed to 1102, and the format is: 1102XXX 
 7. The left Four digits of the event process Error Code are fixed to 1103, and the format is: 1103XXX 
 8. host process Error Code left Four fixed bits 1104| 1110 in the format: 1104XXX| 1110xxx 
 9. The Four fixed bits on the left side of the hostcontroller process Error Code are 1106, and the format is: 1106XXX 
 10. The Four fixed bits on the left side of the proccontroller process Error Code are 1107, and the format is: 1107XXX 
 11. The left Four fixed bits of procserver process Error Code are 1108, and the format is: 1108XXX 
 12. The Four fixed bits on the left side of the auditlog process Error Code are 1109, and the format is: 1109XXX 
 13. The Four fixed bits on the left side of the web process Error Code are 1111, and the format is: 1111XXX 
 14. The Four fixed bits on the left side of the api server v2 Error Code are 1170, and the format is: 1170XXX 

 ## common 

 ```json 
 { 
	 "1199000": "failed to index JSON data", 
	 "1199001": "failed to index JSON", 
	 "1199002": "HTTP Request failed", 
	 "1199003": "Invalid Input Parameters", 
	 "1199004": "data read failed", 
	 "1199005": "Input content empty", 
	 "1199006": "data Parameter Check of '%s' Fail", 
	 "1199007": "'%s' Must be of string", 
	 "1199008": "'%s' cannot be omitted", 
	 "1199009": "The '%s' Parameter Must be an integer", 
	 "1199010": "'%s' is not Assign", 
	 "1199011": "The '%s' Parameter is invalid or does not exist", 
	 "1199013": "failed to read data in Data Field", 
	 "1199014": "data uniqueness Check Failure, %s is duplicate", 
	 "1199015": "'%s' data out of bounds", 
	 "1199016": "Regular verification of Field '%s' failed", 
	 "1199017": "failed to Query data", 
	 "1199018": "failed to add new data", 
	 "1199019": "No data found", 
	 "1199020": "failed to Update data", 
	 "1199021": "failed to delete data", 
	 "1199022": "Dependent service [%s] Not Started", 
	 "1199023": "Download template not found Object %s", 
	 "1199024": "'%s' Must be of string type, 
	 "1199025": "'%s' Must be boolean type, 
	 "1199026": "setting file missing [%s] configItem", 
	 "1199027": "[%s] authorization information Query failed", 
	 "1199028": "Field value Check Fail", 
	 "1199029": "There is a problem with the format of the Function Return value", 
	 "1199030": "Request Parameter format Error, parsing HTTP Body data failed", 
	 "1199031": "'%s' failed to initialize", 
	 "1199032": "The '%s' Parameter is expected to be string", 
	 "1199033": "failed to obtain Field attribute. Error Message: %s", 
	 "1199034": "'%s' Must be an enum type", 
	 "1199035": " %s exceeds Limit %d", 
	 "1199038": "data %s Can not be empty", 
	 "1199039": "%s Field does not exist in model % s", 
	 "1199040": "Transformer %s Field of %s model to %s, Error:%s", 
	 "1199041": "Processing %s, Error:%s", 
	 "1199042": "'%s' Parameter should be a floating point number", 
	 "1199043": "Field value Check Fail, %s", 
	 "1199044": "Not All succeeded", 
	 "1199045": "failed to parse authorization information", 
	 "1199046": "Authentication failed", 
	 "1199047": "No auth to Operation", 
	 "1199048": "auth Check Failure", 
	 "1199049": "failed to register resources to IAM", 
	 "1199050": "failed to unregister resources to IAM", 
	 "1199051": "Unexpected access, auth service is close", 
	 "1199052": "Multiple records obtained", 
	 "1199053": "BlueKing accessCenter is Not Enabled", 
	 "1199054": "Built-in node, cannot be delete", 
	 "1199055": "Prohibit parent node record", 
	 "1199056": "delete referenced records is prohibited", 
	 "1199057": "failed to parse serviceId from Metadata in database", 
	 "1199058": "failed to Generate record ID", 
	 "1199059": "The Quantity of paged Query exceeds the Maximum, 200 is recommended", 
	 "1199060": "Unexpected Parameter Field: `%s`", 
	 "1199061": "failed to parse database data", 
	 "1199062": "failed to obtain Business Name Default cluster module information", 
	 "1199063": "The Count of API Request Parameter is insufficient", 
	 "1199064": "Function call Parameter Error", 
	 "1199065":"failed to enable transaction, Error:%s", 
	 "1199066":"submit transaction failed, Error:%s", 
	 "1199067":"cancel transaction failed, Error:%s", 
	 "1199068":"Query for resources %s with auth failed", 
	 "1199069":"failed to parse property enumeration content", 
	 "1199070": "Invalid value %s for Parameter %s", 
	 "1199071":"failed to assemble database Query Parameter", 
	 "1199072": "failed to obtain the location link of the accessCenter. Please consult the BlueKing Permission Center", 
	 "1199073": "Field %s Maximum value exceeded %d", 
	 "1199074": "Global CCError not initialized", 
	 "1199075": "Disable Operation mainline model instances using the general instance interface", 
	 "1199076": "Disable Update built-in Cloud area", 
	 "1199077": "The Counts for One operation exceeds the maximum Limit: %d", 
	 "1199078": "module [%s] does not exist in Business Name topology", 
	 "1199079": "Business Name [%s] does not exist", 
	 "1199080": "failed to parse attribute list content", 
	 "1199081": "The Counts for One operation exceeds the maximum Limit: %d", 
	 "1199082": "failed to get the The resource list with permission from the accessCenter", 
	 "1199083": "Prohibit Revise Field: %s", 
	 "1199084": "Disable Operation built-in model instances using the general instance interface", 
	 "1199085": "unknown Type: %s", 
	 "1199086": "failed to obtain corresponding serviceId according to Host ID", 
	 "1199087": "The same Task [%s] already exists Running", 
	 "1199088": "Operation Redis cache failed", 
	 "1199089": "%s array length Error, array length Must be between 1~%d", 

	 "1109001": "failed to save operatorAudit log", 
	 "1109002": "failed to create operatorAudit snapshot", 
	 "1109003": "failed to get operatorAudit log", 

	 "1199998": "unknown or Identify abnormal", 
	 "1199999":"Internal Error on '%s' service", 
 } 

 ``` 

 ### event_server 

 ```json 
 { 
	 "1103000": "failed to create subscription", 
	 "1103001": "delete subscription failed", 
	 "1103002": "Update subscription failed", 
	 "1103003": "failed to Query subscription", 
	 "1103004": "Test Push failed", 
	 "1103005": "Testing connectivity failed", 
	 "1103006": "Push event failed", 
 } 

 ``` 
### host_controller

```json
{
	 "1106000":"Failed to query host instance", 
	 "1106002":"Failed to add CVM instance", 
	 "1106003":"Failed to query host snapshot", 
	 "1106004":"Transfer host module failed", 
	 "1106005":"Failed to delete host default cluster module", 
	 "1106006":"Failed to get host module relationship", 
	 "1106007":"Failed to delete original host module relationship", 
	 "1106008":"Failed to obtain the relationship module bound to the host", 
	 "1106009":"Failed to transfer host from resource pool", 
	 "1106010":"CVM already belongs to other business. Please refresh the page and select the CVM to be assigned again", 
	 "1106011":"The host belongs to a module other than the idle machine", 
	 "1106012":"Failed to transfer host to resource pool", 
	 "1106013":"Add user-defined configuration", 
	 "1106014":"Failed to query host favorite", 
	 "1106015":"Failed to create host favorites", 
	 "1106016":"Failed to modify host favorites", 
	 "1106017":"Failed to delete host favorites", 
	 "1106019":"Snapshot channel is empty in last 1 minute", 
	 "1106020":"Communication with snapshot data channel disconnected", 
	 "1106021":"Failed to create cloud sync task", 
	 "1106022":"Failed to add resource confirmation history", 
	 "1106023":"Failed to query synchronization history", 
	 "1106024":"Failed to query CVM snapshots in batch", 
 } 

 ``` 

 ### host_server 

 ```json 
 { 
	 "1110001":"Failed to query host", 
	 "1110002":"Update host failed", 
	 "1110003":"Failed to update host field", 
	 "1110004":"Failed to create host", 
	 "1110005":"Failed to modify host", 
	 "1110006":"Failed to delete host", 
	 "1110007":"Host field verification failed", 
	 "1110008":"Host not found", 
	 "1110009":"host length error", 
	 "1110010":"Failed to get host details", 
	 "1110011":"Failed to get host snapshot data", 
	 "1110012":"Host field verification failed", 
	 "1110013":"Failed to add host favorite", 
	 "1110014":"Host favorite name is empty", 
	 "1110015":"Failed to update host favorites", 
	 "1110016":"Failed to delete host favorites", 
	 "1110017":"Failed to get host favorites", 
	 "1110018":"Failed to create host query history", 
	 "1110019":"Failed to obtain host query history", 
	 "1110020":"Failed to save field configuration", 
	 "1110021":"Failed to get field configuration", 
	 "1110022":"Failed to get default field configuration", 
	 "1110023":"Host ID ' % v' does not belong to the current business", 
	 "1110024":"Failed to get business for host ' % v'", 
	 "1110025":"Failed to remove host ' % s' from resource pool, error: % s", 
	 "1110026":"Failed to add host ' % s' to module relationship, error: % s", 
	 "1110027":"Host ' % s' failed to transfer to resource pool, error: % s", 
	 "1110028":"Failed to modify host relationship", 
	 "1110029":"Failed to add host to module", 
	 "1110030":"Failed to add host to module, error: % s", 

	 "1110040":"Failed to add custom query, % s", 
	 "1110041":"Failed to modify custom query, % s", 
	 "1110042":"Delete custom query failed, % s", 
	 "1110043":"Query custom query failed, % s", 
	 "1110044":"Failed to get custom query details, % s", 
	 "1110045":"Failed to get host relationship, % s", 
	 "1110046":"Failed to acquire cluster, % s", 
	 "1110047":"Failed to get business, % s", 
	 "1110048":"Service % v does not exist", 
	 "1110049":"Failed to get module, % s", 
	 "1110050":"Get host agent status, % s", 
	 "1110051":"Resource pool not found", 
	 "1110052":"Host already belongs to resource pool", 
	 "1110053":"Failed to get resource pool information, % s", 
	 "1110054":" % s module does not exist", 
	 "1110055":"Failed to delete CVM under business", 
	 "1110056":"Operation failed, the following hosts do not belong to the target module:%s", 
	 "1110057":"Module does not exist or multiple built-in modules exist", 
	 "1110058":"bject object in parameter is missing bk_inst_id field", 
	 "1110059":"Cluster ID [ % d] does not exist", 
	 "1110060":"Cluster ID [ % d] does not belong to business ID [ % d]", 
	 "1110061":"Module ID [ % d] does not belong to business ID [ % d]", 
	 "1110062":"Module ID [ % d] does not belong to cluster ID [ % d]", 
	 "1110063":"Failed to create cloud zone, required field bk_cloud_name is missing", 
	 "1110064":"Failed to create cloud zone, cloud zone name already exists", 
	 "1110065":"Failed to query cloud region, failed to add host_count field", 
	 "1110066":"Default cloud zone cannot be deleted", 
	 "1110067":"Failed to query cloud area, failed to add sync_task_ids field", 

	 "1110080":"Failed to add host to resource pool", 
 } 


 ``` 

 ## migrate 

 ```json 
 { 
         "1105000":"Failed to migrate data, % s", 
         "1105001":"Failed to initialize rights center:%s", 
 } 
 ``` 

 ## object_controller 

 ```json 
 { 
	 "1102000":"Attribute grouping storage failed", 
	 "1102001":"Failed to delete attribute grouping", 
	 "1102002":"Failed to query attribute grouping", 
	 "1102003":"Failed to update attribute grouping", 
	 "1102004":"Failed to add instance", 
	 "1102005":"Failed to update instance", 
	 "1102006":"Failed to delete instance", 
	 "1102007":"Failed to query instance", 
	 "1102008":"Failed to query identity", 
 } 


 ``` 

 ## proc_controller 

 ```json 
 { 
        "1107001":"Failed to remove process from module", 
        "1107002":"Failed to add process to module", 
        "1107003":"Query process failed", 
        "1107011":"Failed to delete process template binding", 
        "1107012":"Failed to bind new process template", 
        "1107013":"Query process template binding failed", 
 } 


 ``` 

 ## proc_server 

 ```json 
 { 
	 "1108001":"Failed to query process details", 
	 "1108002":"Failed to bind process model", 
	 "1108003":"Failed to unbind process model", 
	 "1108004":"Failed to unbind process model", 
	 "1108005":"Update process failed", 
	 "1108006":"Query process failed", 
	 "1108007":"Delete process failed", 
	 "1108008":"Failed to create process", 	
	 "1108013":"Binding module exists under the process", 
	 "1108014":"Failed to delete configuration template", 
	 "1108015":"Failed to update configuration template", 
	 "1108016":"Failed to query configuration template", 
	 "1108017":"Failed to bind template to process", 
	 "1108018":"Failed to unbind template process", 
	 "1108019":"Failed to query process template binding relationship", 
	 "1108020":"Failed to query process execution status", 
	 "1108021":"process operation waiting to be executed", 
	 "1108022":"An error occurred in the process operation", 
	 "1108023":"Failed to create configuration template", 
	 "1108024":"Failed to query process service instance list", 
	 "1108025":"Failed to create process service instance", 
	 "1108026":"Failed to delete process service instance", 
	 "1108027":"Failed to query process template", 
	 "1108028":"Failed to query process instance", 
	 "1108029":"Failed to query process instance relationship", 
	 "1108030":"Failed to delete service template", 
	 "1108031":"Failed to create process template", 
	 "1108032":"Failed to update process template", 
	 "1108033":"Failed to query process template", 
	 "1108034":"Failed to query default service classification", 
	 "1108035":"It is forbidden to directly add/modify process instances for service instances created by templates", 
	 "1108036":"Service classification is inconsistent with service template", 
	 "1108037":"Module is not bound to service template", 
	 "1108038":"Create service instance module template information is inconsistent with HTTP interface", 
	 "1108039":"Prohibit adding processes on service instances with templates", 
	 "1108040":"Failed to unbind module template", 
	 "1108041":"Failed to generate service instance name", 
	 "1108042":"Unbinding module template is disabled", 
	 "1108043":"Failed to query service classification", 
	 "1108044":"Host transfer failed, target module cannot contain built-in module and other modules", 
 } 
```

## topo_server

``` json
{
	 "1101000": "failed to create instance", 
	 "1101001": "failed to delete instance", 
	 "1101002": "failed to Update instance", 
	 "1101003": "failed to Query instance data", 
	 "1101004": "failed to New", 
	 "1101005": "failed to Delete Model", 
	 "1101006": "failed to Update model", 
	 "1101007": "Query model failed", 
	 "1101008": "failed to create Set", 
	 "1101009": "failed to delete Set", 
	 "1101010": "failed to Update Cluster information", 
	 "1101011": "failed to Query Cluster information", 
	 "1101013": "failed to New", 
	 "1101014": "failed to Delete Model", 
	 "1101015": "Update model failed", 
	 "1101016": "Query model failed", 
	 "1101017": "failed to Model Properties", 
	 "1101018": "failed to Delete Model Properties", 
	 "1101019": "failed to Update Model Properties", 
	 "1101020": "failed to Query Model Properties", 
	 "1101021": "failed to New Service Classification", 
	 "1101022": "failed to Delete Model Service Classification", 
	 "1101023": "failed to Update model Service Classification", 
	 "1101024": "failed to Query model Service Classification", 
	 "1101025": "failed to Model Properties group", 
	 "1101026": "failed to Delete Model Properties group", 
	 "1101027": "failed to Update Model Properties group", 
	 "1101028": "failed to Query Model Properties group", 
	 "1101029": "There is a model under the Service Classification. Allow delete", 
	 "1101030": "target contains Host, delete is not Allow", 
	 "1101131": "failed to delete Business Name", 
	 "1101132": "failed to Update Business Name", 
	 "1101133": "failed to Query Business Name", 
	 "1101134": "failed to create Business Name", 
	 "1101135": "Disable delete of built-in model", 
	 "1101137": "failed to create main line", 
	 "1101138": "failed to delete main line", 
	 "1101139": "failed to Query main line", 
	 "1101140": "failed to Query model topology", 
	 "1101141": "create user group", 
	 "1101142": "delete user group", 
	 "1101143": "Update user group", 
	 "1101144": "Query user group", 
	 "1101145": "Update user group auth", 
	 "1101146": "Query user group auth", 
	 "1101147": "Query user auth", 
	 "1101148": "create Role auth", 
	 "1101149": "There are instances with duplicate names at this level. failed to delete.  ", 
	 "1101150": "Host does not support Business Name transfer", 
	 "1101151": "failed to Query model topology", 
	 "1101152": "failed to Update model topology", 
	 "1101031": "failed to Query Cloud area, %s", 
	 "1101032": "Cloud area does not exist", 
	 "1101033": "failed to Query Business Name", 
	 "1101034": "Query module failed,%s", 
	 "1101035": "Business Name topology level exceeds limit", 
	 "1101036": "Instance [Instance ID: %d] is already link, not Allow delete or Archive ", 
	 "1101037": "The model [%s] has been instantiate, and cannot be delete", 
	 "1101038": "link %s->%s is duplicate", 
	 "1101039": "link source model does not exist", 
	 "1101040": "The link target model does not exist", 
	 "1101041": "Invalid link ID, should be a positive integer", 
	 "1101042": "Multiple link relationship instances found", 
	 "1101043": "The model link relationship has been instantiate and cannot be delete", 
	 "1101044": "failed to Query link type [%s]", 
	 "1101045": "The model link relationship is missing relevant Parameter", 
	 "1101046": "The model link does not exist", 
	 "1101047": "contains Field that are not Allow to be Update", 
	 "1101048": "link relation of mainline model [%s->%s] does not exist", 
	 "1101049": "link relation import failed", 
	 "1101050": "Multiple link instances Query", 
	 "1101051": "The preset link type cannot be delete", 
	 "1101052": "Multiple instances cannot be associated with an link relationship of 1:1", 
	 "1101053": "model already link", 
	 "1101054": "Disable Update predefined link", 
	 "1101055": "Disable delete predefined link", 
	 "1101056": "link does not exist", 
	 "1101057": "bk_inst_name Field value is missing for row %s", 
	 "1101058": "line %s bk_inst_name value is not a character type", 
	 "1101059": "bk_inst_name %s has duplicate values", 
	 "1101060": "link type already used", 
	 "1101061": "Multiple source model instances cannot be associated simultaneously if the link relationship is 1:n", 
	 "1101160":"failed to New group unique", 
	 "1101161":"Update model group unique failed", 
	 "1101162":"Failed to Delete Model group unique", 
	 "1101163":"failed to Query model group", 
	 "1101164":"Model Properties [%s] remove", 
	 "1101165":"Model Properties [%s] has been uniquely referenced by group, delete failed", 
	 "1101166":"Illegal unique item type [%s]", 
	 "1101167":"Built-in unique items are not Allow to be Revise or delete", 
	 "1101168":"model cannot have more than one unique check that Must be Check", 
	 "1101069":"The model needs at least One set of isRequired unique Check items", 
	 "1101070":"link type has been Apply to model", 
	 "1101071":"Predefined link type cannot be delete", 
	 "1101072":"link type does not exist", 
	 "1101073":"link instance does not exist", 
	 "1101074":"The link instance does not exist", 
	 "1101075":"There is an link relationship under the instance", 
	 "1101076":"failed to create link type", 
	 "1101077":"failed to Update link type", 
	 "1101078":"failed to delete link type", 
	 "1101080":"Topology module not found", 
	 "1101081":"Topology Apply Allow delete", 
	 "1101082":"bk_mainline is a built-in link type and cannot be used in the current Scene", 
	 "1101083":"link type does not match call entry", 
	 "1101084": "model has been Disable", 
	 "1101085": "Cannot change the unique Check of the mainline model", 
	 "1101086": "failed to Query the Biz list with auth", 
	 "1101087": "There is a Host under the Archive Business Name, and archiving is prohibited", 
	 "1101088": "failed to Query Search content", 
	 "1101089": "Full Text Search not initialized", 
	 "1101090": "Do not Revise the Service Classification of a module create by a template", 
	 "1101091": "Do not Revise the name of a module create by a template", 
	 "1101092": "isRequired Field attribute cannot be new for mainline model", 
	 "1101093": "%d row model ID is inconsistent with URL", 
	 "1101094": "Mainline model instance. Operation approve excel is not Allow", 
	 "1101095": "failed to synchronize cluster Template", 
	 "1101096": "Synchronize cluster Template Task Running", 
	 "1101097": "Set is create by cluster Template. append/delete module is prohibited", 
	 "1101098": "Do not delete built-in Set/module", 
	 "1101099": "module with the same name already exists", 

	 "1101100": "URL Parameter parsing failed", 
	 "1101101": "failed to Query Model Properties. Please permissionRefreshOkText", 
	 "1101102": "model not found", 
	 "1101102": "Only resources pool directory name can be Update", 
	 "1101103": "%s resources pool directory failed, directory does not exist", 
	 "1101104": "Idle machine directory Allow delete", 
	 "1101105": "resources pool directory is being used by cloud sync Task", 
 } 

 ``` 

 ## api_v2 

 ``` json 
 { 
	 "1170001":"Business Name Must 1-32 characters", 
	 "1170002":"%s", 
	 "1170003":"Set name length cannot exceed 24 bytes", 
	 "1170004":"Each module ID Must be numeric", 
	 "1170005":"Each Set ID Must be a number", 
	 "1170006":"osType Must be windows or linux", 
	 "1170007":"module transfer cannot contain default module", 
 } 

 ``` 

 ## apiserver 

 ``` json 
 { 
	 "1100001":"Error in API obtaining authorized Biz list from accessCenter", 
	 "1100002":"failed to get user's resources authentication authentication status", 
	 "1100003":"Object instance not found", 
 } 
 ``` 

 ## cloudserver 

 ``` json 
 { 
	 "1118001": "Cloud vendor not supported", 
	 "1118002": "Account name hasExisted", 
	 "1118003": "Verification of cloud account Parameter %s failed", 
	 "1118004": "Cloud account ID %d does not exist", 
	 "1118005": "Task Name hasExisted", 
	 "1118006": "Cloud synchronization Task Parameter %s Check Failure", 
	 "1118007": "Parameter bk_vpc_id Can not be empty", 
	 "1118008": "Cloud vendor API call failed", 
	 "1118009": "The same SecretID already exists in cloud account %s", 
	 "1118010": "The cloud account already has cloud sync Task %s", 
	 "1118011": "The SecretID or Key of the cloud account does not match", 
	 "1118012": "The call of the cloud vendor HTTP Request timed out", 
	 "1118013": "failed to obtain VPC information of cloud vendor", 
	 "1118014": "failed to obtain cloud vendor region information", 
	 "1118015": "Cloud sync directory not select", 
	 "1118016": "Cloud sync directory ID %d does not exist", 
	 "1118017": "Cloud area ID not provided", 
	 "1118018": "Cloud area id %d does not exist", 
	 "1118019": "Default Cloud area cannot be used", 
	 "1118020": "Cloud account create failed", 
	 "1118021": "failed to obtain cloud account setting in Batch", 
	 "1118022": "failed to delete resources related to the destory Host", 
	 "1118023": "failed to delete the cloud account. The cloud synchronization Task has been Binding to it." 
 } 
 ``` 

## coreservice

``` json
{
     "1113001": "Field group contains some fields", 
    "1113002": "Host ID[%#v] does not belong to serviceId [%#v]", 
    "1113003": "Host ID[%#v] does not exist", 
    "1113004": "module ID[%#v] does not belong to serviceId [%v]", 
    "1113005": "Transfer Host to multiple Modules does not include built-in modules", 
    "1113006": "Business Name [%#v] does not exist", 
    "1113007": "Business Name [%#v] built-in module does not exist", 
    "1113008": "businessID [ % d] of moduleID [ % d] is not a built-in module", 
    "1113009": "Transfer Host module failed", 
    "1113010": "Failed to send event", 
    "1113011": "Do not release (transfer to idle machine/failed machine/to be recycled/resources pool) the Host link with the service instance", 
    "1113012": "Disable Host remove from idle/failed/module to be recycled", 
    "1113013": "Error interface called when transferring Host to default module", 
    "1113014": "The module is not Binding a Service Template. Cannot create a service instance synchronously", 
    "1113015": "Specified Host not found", 
    "1113016": "service instance [%s] already exists", 
    "1113017": "Duplicate Service Doc Category Name [ %s]", 
    "1113018": "module is inconsistent with service instance template", 
    "1113019": "process aliasName [%s] unique Check Failure", 
    "1113020": "Process Name [%s]+ Start Up Parameter [%s] unique Check Failure", 
    "1113021": "module not Binding to template", 
    "1113022": "Process [%s] create approve template is not allowed to be delete", 
    "1113023": "delete [%s] data in multiple model", 
    "1113024": "delete of Field in unique check is not Allow", 
    "1113025": "Revise the description of a property that is not Allow to be modified", 
    "1113026": "model [%s] does not Allow new isRequired Field", 
    "1113027": "model [%s] does not Allow Revise isRequired Field", 
    "1113028": "model [%s] does not Allow new Field", 
    "1113029": "model [ %s] Allow delete", 
    "1113030": "Example Data under model", 
    "1113031": "model is link with Other models", 
    "1113032": "Only leaf node Service Classification are Allow", 
    "1113033": "Too much search data", 
    "1113033": "resources pool directory does not exist", 
    "1113034": "The following Host are not in any resources pool directory: %d", 
    "1113050": "The same unique Check rule already exists", 
 } 
 ``` 

 ## datacollection 

 ``` json 
 { 
    "1112000": "failed to add device", 
    "1112001": "failed to find device", 
    "1112002": "failed to delete device", 
    "1112003": "model ID or model name is not a network Collections device", 
    "1112004": "failed to add network device attribute", 
    "1112005": "failed to find network device properties", 
    "1112006": "failed to delete network device properties", 
    "1112007": "Attribute does not exist", 
    "1112008": "Device does not exist", 
    "1112009": "failed Format period Field", 
    "1112010": "The device Configured properties, delete failed", 
    "1112011": "failed to Query Collections", 
    "1112012": "failed to Update Collections", 
    "1112013": "failed to execute discovery", 
    "1112014": "Query report failed", 
    "1112015": "failed to Confirm change", 
    "1112016": "failed to Query change history", 
    "1112017": "failed to Update device", 
    "1112018": "failed to Update network device properties", 
 } 
 ``` 

 ## operationserver 

 ``` json 
 { 
	 "1116001": "failed to obtain the Quantity of Business Name, module and Host", 
	 "1116002": "failed to new Statistics", 
	 "1116003": "Statistics already exists", 
	 "1116004": "failed to delete statistical chart", 
	 "1116005": "failed to get statistical chart", 
	 "1116006": "failed to Update statistics chart", 
	 "1116007": "failed to get chart data", 
	 "1116008": "failed to Update chart position" 
 } 
 ``` 

 ## web 

 ``` json 
 { 
	 "1111001":"Upload not found", 
	 "1111002":"failed to save file %s", 
	 "1111003":"failed to open file %s", 
	 "1111004":"file content Can not be empty,%s", 
	 "1111005":"failed to get file content,%s", 
	 "1111006":"failed to get Host data, Error:%s", 
	 "1111007":"failed to create EXCEL file, Error:%", 
	 "1111008":"failed to get instance data, Error:%s", 
	 "1111009":"failed to get new device result, Error:%s", 
	 "1111010":"failed to get new device attribute result, Error:%s", 
	 "1111011":"failed to get device data, Error:%s", 
	 "1111012":"failed to get device property data, Error:%s", 
	 "1111013":"Please enter your username and password", 
	 "1111014":"username or password is Error, please Input", 
	 "1111015":"username and password information is Not configured. Please configure the session.user_info configItem in the common.conf file", 
	 "1111016":"The username and password setting format is Error. Please check the session.user_info configItem", 
	 "1111017":"unknown signIn version %s", 
 } 
 ``` 
 ## taskserver 

 ``` json 
 { 
	 "1117001": "Task does not exist", 
	 "1117002": "Task does not exist", 
	 "1117003": "Task Total is not Allow to change to %v", 
	 "1117004": "Task Task Total is failed. Error Return Allow empty", 
	 "1117005": "failed to lock Task", 
	 "1117006": "Task unlocking failed", 
	 "1117007": "Query Failed", 
 } 
 ``` 

 ## synchronize 

 ``` json 
 { 
	 "1113900": "data synchronization failed", 
	 "1113901": "%s type data synchronization, data exists with type %s", 
	 "1113902": "data synchronization failed", 
 } 
 ``` 