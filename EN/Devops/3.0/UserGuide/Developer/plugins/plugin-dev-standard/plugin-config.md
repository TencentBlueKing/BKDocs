 # Plugin Config Specification 

 ## One. Description 

 * Each Plugin has One remarkFile named task.json with Input Field, Output Field, and Start Up commands, all described by the Develop in task.json 
 * description the Input Field so that the user can setting customize variableVal when programming Pipeline. 
 * description Output Field so that the user can understand the atomOutput for use in downstream step when programming Pipeline 
 * description the Start Up command so that BK-CI knows how to start Plugin execute 
 * The remarkFile (task.json) is stored in the root directory of the Plugin Code Repository 
 * remarkFile (task.json) content format is json 

 ## Two. Detailed Data Schema of task.json 

 ### The overall structure is as follows 

 ```text 
 { 
    "atomCode": "",     # Unique Plugin ID, composed By English letters, consistent with the ID specified during plug-in initialization 
    "execution": {      # execute command entry related 

    }, 
    "inputGroups": [    # Input Field group, optional. After Set, input fields can be displayed by group. Expand open collapse by group are supported. 

    ], 
    "input": {          # Plugin Input Field definition 

    }, 
    "output": {         # Output Field definition 

    } 
 } 
 ``` 

 task.json example: 
 ```text 
 { 
    "atomCode": "demo", 
    "execution": { 
        "language": "python", 
        "packagePath": "demo-1.1.0.tar.gz",             # Relative path of Plugin install package in Release package 
        "demands": [ 
            "pip install demo-1.1.0.tar.gz --upgrade"   # Operation to be performed before execute the target command, such as install dependencies, etc. 
        ], 
        "target": "demo" 
    }, 
    "input": { 
        "inputDemo":{ 
            "label": "Input example",  
            "type": "vuex-input", 
            "placeholder":"Input example", 
            "desc": "Input example" 
        } 
    }, 
    "output": { 
        "outputDemo": { 
            "description":"Output example", 
            "type": "string", 
            "isSensitive": false 
        } 
    } 
 } 
 ``` 

 ### Details of configItem 

 #### atomCode 

 * Unique Plugin ID, composed By English letters, consistent with the ID specified during plug-in initialization 
 * Values are formatted as string 

 #### execution 

 * execute command entry related setting 
 * Values are formatted as Object 
 * Value Object include the following attributes: 

 | attribute name| attribute Description| Format| remark| 
 | :--- | :--- | :--- | :--- | 
 | packagePath |The relative path of the Plugin execute package in the Release package| string| isRequired, including the name of the execute package. When executing, the execution package will be found according to this setting after the download Release package is decompressed| 
 | language |Development language| string| isRequired, such as python, java, etc., consistent with the language specified during Plugin initialization| 
 | demands |execute dependency| array| (not required)| 
 | target |execute entry| string| isRequired, generally a command that can be execute on the command line| 

 #### inputGroups 

 * Input Field group is optional. After Set, input fields can be displayed by group. Expand open collapse by group are supported fold 
 * Values are formatted as arrays 
 * Multiple groups can be Set, and each group is description by One Object, including the following attributes: 

 | attribute name| attribute Description| Format| remark| 
 | :--- | :--- | :--- | :--- | 
 | name |groupName| string| isRequired, setting in the groupName of the Input Field, to identify which group The field belongs to| 
 | label |group identification| string| isRequired, the groupName directly seen by the user| 
 | isExpanded |open or not| Boole| isRequired, open group by default| 

 ### input 

 * Input Field definition 
 * Values are formatted as Object 
 * One or more Input Field (s) can be setting 
 * The English identifier of each Input Field is key, and value is Object 

 **The system supports the following UI Components** 

 | Components type| Component Name| remark| Description of the value obtained by the Plugin background during execute| 
 | :--- | :--- | :--- | :--- | 
 | vuex-input |Single-line textarea||string| 
 | vuex-textarea |Multiline textarea||string| 
 | atom-ace-editor |Code edit box||string| 
 | selector |drop-down box| You can only select, not Input| string| 
 | select-input |Drop-down box for Input| The Input value can be a value (including var) not in the drop-down list. After selecting it, you will see the id of Yes in the box.| string| 
 | devops-select |Drop-down box for Input| The Input value can only be a var. After selection, name is shown in the box.| string| 
 | atom-checkbox-list |multiple List||string, such as: \[ "id1", "id2" \]| 
 | atom-checkbox |multiple (Boolean)||string| 
 | enum-input |single choice||string| 
 | cron-timer |time select||string| 
 | time-picker |date select||string| 
 | user-input |name select||string| 
 | tips |Tips| Support dynamic pipelinesPreview user Input Parameter, support link| string| 
 | parameter |indefinite Parameter list| Parameter list can be obtained from API| string| 
 | dynamic-parameter |indefinite Parameter list| It can be obtained from APIs, multiple columns per row, and dynamic addition/deletion.| string| 

 If the above Components do not meet the requirements, please contact BK-CI customer service. 

 **Each Input Field configuration supports the following common attributes** 

 | attribute name| attribute Description| setting format| remark| 
 | :--- | :--- | :--- | :--- | 
 | label |alias| string| For presentation, Allow to be empty (Scene combined with Other Field)| 
 | type |Components type| string| isRequired. The platform provided Starred Input Components, which are displayed differently according to different components.| 
 | default |defaultValue| The defaultValue format is different according to different Components| (not required)| 
 | placeholder | placeholder |string| (not required)| 
 | groupName |Group| string| (not required), name definition in inputGroups| 
 | desc |Field Description| string| (not required), Field Description, supports\r\nline feed| 
 | required |required| Boole| (not required)| 
 | disabled |edit| Boole| (not required)| 
 | hidden |Hide or not| Boole| (not required)| 
 | isSensitive |Sensitive| Boole| (not required). Sensitive information will not be displayed in clearText in the log| 
 | rely |Display/Hide current Field based on criteria| Object| (not required)| 
 | rule |Value validity Limit| Object| (not required)<br/> The following properties are supported:<br/> alpha: Allow English characters, Boolean, true/false<br/> numeric: Allow, boolean, true/false<br/> alpha_dash: can contain A to z character, underscores, Boolean, true/ false<br/> alpha_num: can contain English and numbers, Boolean, true/false<br/> max: Maximum length string, int<br/> min: Minimum length string, int<br/> regex: Regular Expression string| 

 **example of rule setting:** 
 ```json 
 //Only letters Fill In Allow, and string length is 3-7 
 "rule": { 
    "min": 3, 
    "max": 7, 
    "alpha": true 
 } 

 //Regular match string starting with a number 
 "rule": { "regex": "^[0-9]" } 
 ``` 

 **Personalized attributes for Components of different types** 

 **1. Single-line textarea: type=vuex-input** 

 * Components Attributes: 
  * inputType: used when the Input string is expected to be displayed as\*\*\*\*\*\*, the value is password 
 * example: 
  * setting 

    ```text 
    "fieldName": { 
        "label": "password Input box", 
        "type": "vuex-input", 
        "inputType": "password", 
        "desc": "XXX" 
    } 
    ``` 

 **2. multiple (Boolean): type = atom-checkbox** 

 * Components Attributes: 
  * text: label can be Set to null, corresponding value is true/false 
 * example: 
  * setting 

    ```text 
    "fieldName": { 
        "label": "", 
        "default": true, 
        "type": "atom-checkbox", 
        "text": "Rebuild required", 
        "desc": "XXX" 
    } 
    ``` 

 **3. Drop-down box/drop-down box for Input: type = selector/select-input/devops-select** 

 * Components Attributes: 
  * optionsConf： Drop-down box attribute setting 

    ```text 
    "optionsConf": {          # type=selector/select-input/devops-select Component Config 
        "searchable": false, # Is it search 
        "multiple": false,    # Is it multi-choice 
        "url": "",            # BK-CI service link, or API link to BlueKing Gateway 
                                var are supported in the link, which can be referenced by {Name}. They can be Field in the current task.json, or several Built-in variables, such as projectId, pipelineId, and buildId. 
        "dataPath": "",       # The path in the API Return body json where the options list data is located. If this Field is not present, it defaults to data. example: data.detail.list。  Use with URL 
        "paramId": "",        # url returns the Name of the drop-down list options key in the specification, which is used in conjunction with url 
        "paramName": "",      # url returns the Name of the drop-down list options label in the specification, used in conjunction with url 
        "hasAddItem": true,   # Whether there is a new button (only Take Effect when type=selector) 
        "itemText": "Copy",   # new button text description (only Take Effect when type=selector) 
        "itemTargetUrl":"location url"    # click the location address of the new button (only Take Effect when type=selector) 
    } 
    ``` 

    * BK-CI service link, you can use the browser Develop assistant grab, Starred links are as follows: 
      * Credentials: /ticket/api/user/credentials/{projectId}/hasPermissionList?  permission=USE&page=1&pageSize=100&credentialTypes=USERNAME\_PASSWORD 
        * For more information on how to get the value of credentialTypes, see [CredentialType](https://github.com/TencentBlueKing/bk-ci/blob/master/src/backend/ci/core/ticket/api-ticket/src/main/kotlin/com/tencent/devops/ticket/pojo/enumers/CredentialType.kt). 
      * codelib/repository/api/user/repositories/{projectId}/hasPermissionList?  permission=USE&repositoryType=CODE\_GIT&page=1&pageSize=5000 
        * For more information on how to get the value of repositoryType, see [ScmType](https://github.com/TencentBlueKing/bk-ci/blob/master/src/backend/ci/core/common/common-api/src/main/kotlin/com/tencent/devops/common/api/enumers/ScmType.kt). 
      * node: /environment/api/user/envnode/{projectId}/listUsableServerNodes?  page=1&pageSize=100 

  * options: drop-down box list item definition 

    ```text 
    "options": [              # type=selector/select-input Components options List 
        {  
            "id": "",         # options ID 
            "name": "",       # options name 
            "desc": "",       # options Description 
            "disabled": false # Optional 
        } 
    ] 
    ``` 

 **4. Single choice: type = enum-input** 

 * Components Attributes: 

  * list 

  ```text 
  "list": [                 # type=enum-input Components options List 
        { 
            "label": "", 
            "value": "" 
        } 
    ] 
  ``` 

 **5. date select: type=time-picker** 

 * Components Attributes: 
  * startDate: Timestamp, ms, start date 
  * endDate: Timestamp, ms, end date 
  * showTime: Boolean, whether to showTime 

 **6. Tips tips** 

 * Components Attributes: 
  * tipStr: Tips content template 
  * Supports {0} Other var that reference the current Plugin 
  * Support for insert link 
 * example: 
  * example setting: 

    ```text 
    "tipTest": { 
         "label": "", 
         "type": "tips", 
         "tipStr": "This is a XXX system, welcome to experience.  [click](www.baidu.com)" 
    } 
    ``` 

 **7. Variable Parameter list: parameter** 

 * Components Attributes: 
  * paramType: data is dynamic obtained from link or from the definition list. Available values are: url、list 
  * url: setting link when paramType=url 
  * urlQuery: The value is an Object, and the Parameter Settings of url are as follows: {"param1": "","param2":""} param1 and param2 can be Other Parameter of the current Plugin, and the values will be Replace auto during execute 
  * parameters: A list of parameters that can definition One or more Parameters Each parameter contains the following properties 

    | attribute name| attribute Description| Format| remark| 
    | :--- | :--- | :--- | :--- | 
    | id |Unique ID of this line| string| Unique ID of this line| 
    | key |The value of key| string| The key of the line Parameter| 
    | keyType |type of key| string| Optional values are input, select| 
    | keyListType |Key RawData type| string| Valid when keyType=select. Available values are url and list.| 
    | keyUrl ||string| Take Effect when keyListType=url| 
    | keyList ||List| It Take Effect when keyListType=list, for example: \[ { id: 'id', name: 'name' } \], id is the specific value of key| 
    | keyDisable |edit| Boole|  true、false | 
    | keyMultiple |Multiple choices allowed| Boole|  true、false | 
    | value |The value of value| string| The value of the row Parameter| 
    | valueType |type of value| string| Optional values are input, select| 
    | valueListType |value RawData type| string| Valid when valueType=select. Available values are url and list.| 
    | valueUrl ||string| Take Effect when valueListType=url| 
    | valueList ||List| Take Effect when valueListType=list, for example: \[ { id: 'id', name: 'name' } \], id is the concrete value of value| 
    | valueDisable |edit| Boole|  true、false | 
    | valueMultiple |Multiple choices allowed| Boole|  true、false | 

 **8. multiple list: type=atom-checkbox-list** 

 * Components Attributes: 
  * list 

    ```text 
    "list":[ 
    { 
        "id":"php" 
        "name":"php" 
        "disabled":true 
        "desc":"PHP is OK language in the world" 
    }] 
    ``` 

 **9. Code edit box: atom-ace-editor** 

 * Components Attributes: 
  * bashConf 
  * lang 

    ```text 
    "bashConf": { 
        "url": "XXX", #Third-party link to BlueKing Gateway 
        "dataPath": "" #e.g. data.name 
    }, 
    "lang": "sh"       #Currently supports highlight syntax json| python| sh| text| powershell| batchfile 
    ``` 

 **10. Name select: user-input** 

 * Components Attributes: 
  * inputType: the Type Of Data that can be Input. The optional values are email, rtx and all. 

    ```text 
    "receiver2": { 
        "label": "recipient, support Email group", 
        "type": "company-staff-input", 
        "inputType": "all", 
        "desc": "You can Fill In any user of the company, including Email groups" 
    } 
    ``` 

 **11. dynamic Parameter Components: dynamic-parameter** 

 * Components Properties 

 ```text 
 "params":{ 
  "label": "dynamic Parameter", 
  "type": "dynamic-parameter", 
  "required": false, 
  "desc": "dynamic Parameter Components", 
  "param": { 
    "paramType":"url", // parameters is to get from url or directly take the list value, can be url or list 
    "url": "XXXX",      //When paramType is url, it is Access from the API.{test} in the url can be Replace with the value in the current Plugin or the Parameter in the browser url. 
    "dataPath": "",     //The Return value of the API, the path of the data retrieval. The default is data.records 
    "parameters": [     //get Access from here when paramType is list 
        { 
            "id": "parameterId", //The unique ID of the row, isRequired 
            "paramModels": [ 
                { 
                    "id": "233",     //Unique ID of The model, isRequired 
                    "label": "testLabel", 
                    "type": "input", //can be input or select 
                    "listType": "url", //Get list method, can be url or list 
                    "isMultiple": false, // select whether to select multiple 
                    "list": [ { "id":"id", "name":"name" } ], // type is select works, need to have id and name Field 
                    "url": '', // type is select and listType is url works 
                    "dataPath": "",     //The Return value of the API, the path of the data retrieval. The default is data.records 
                    "disabled": false, //controls whether it is edit 
                    "value": "abc=" //value, can be used as the defaultValue for initialization 
                } 
            ] 
        } 
    ] 
  } 
 } 
 ``` 

 example of data passed to the Plugin backend during execute:
```
 \[{"id":"parameterId","values":\[{"id":123,"value":"3d029fbe08c011e99792fa163e50f2b5,${{abc}}"},{"id":1233,"value":"ab"},{"id":1235,"value":"id"}\]}\]
```
 **12. Simplified dynamic Parameter Components: dynamic-parameter-simple** 

 * Components Properties 

 | attribute name 	 | attribute Description 	 | isRequired 	 | Format 	 | remark| 
 | :--- | :--- | :--- | :--- | :--- | 
 | rowAttributes[N].id 	 | The unique ID of The attribute,| isRequired| 	 Yes, sir.| 	 String 	 | 
 | rowAttributes[N].type 	 | options: ["input", "select"] 	 | Yes, sir.| 	 String| 	 rowAttributes[N].options entry is required when using "select| 
 | rowAttributes[N].options| 	 Drop-down box options on the page| 	 Yes when rowAttributes[N].type is "select"| 	 Array Of Instance Option 	 | 
 | rowAttributes[N].options[M].name| 	 Display value on the page| 	 Yes when rowAttributes[N].type is "select" 	 | String 	 | 
 | rowAttributes[N].options[M].id 	 | Actual selected value 	 | Yes when rowAttributes[N].type is "select" 	 | String 	 | 

 * setting example 
 ```json 
 { 
  "input": { 
    "input_dynamic_parameter_simple": { 
      "label": "dynamic Parameter (Simplified Version)", 
      "type": "dynamic-parameter-simple", 
      "parameters": [ 
        { 
          "rowAttributes": [ 
            { 
              "id": "ip",               #Unique ID of The property, isRequired 
              "label": "IP", 
              "type": "input",          #Optional values:["input", "select"], if "input" is used,"options" is not Fill In 
              "placeholder": "IP", 
              "desc": "IP info", 
              "default": "8.8.8.8" 
            }, 
            { 
              "id": "protocol_port", 
              "label": "protocol\\port", 
              "type": "select",         #Optional values:["input", "select"], if using "select", Must have "options" item 
              "options": [              #When type is "select", it Must be Fill In 
                { 
                  "id": "80",           The actual selected value 
                  "name": "HTTP\\80"    #Display values on the page 
                }, 
                { 
                  "id": "443",          The actual selected value 
                  "name": "HTTPS\\443" #Display value on page 
                } 
              ], 
              "desc": "protocol\\port" 
            } 
          ] 
        } 
      ], 
      "desc": "dynamic Parameter (easy version) Input example" 
    } 
  } 
 } 

```

 ####Supported Features 

 * Display/Hide current Field based on criteria 
 * example setting: 

 ```text 
 "rely": {                 #Display/Hide current Field configuration according to condition 
    "operation": "AND",   #Multiple conditional and/or, options: AND/OR 
    "expression": [       #Condition List 
        { 
            "key": "",    #Condition Name 
            "value": Any #Condition Field value 
        } 
    ] 
 } 
 ``` 

 ### output 

 #### Output Field definition 

 * Values are formatted as Object 
 * One or more Output Field can be setting 
 * The English identifier of each Output Field is key, and value is Object 
 * Each Output Field definition contains the following attributes: 

 | attribute name| attribute Description| Format| remark| 
 | :--- | :--- | :--- | :--- | 
 | type |type of Output Field| string| isRequired.  The following three types are supported: string: string artifact: The system will auto Archive the output file to the warehouse report: customize report html, the system will auto Storage, rendering in the outputReport interface| 
 | description |description| string| (not required), Description| 
 | isSensitive |Sensitive| Boole| (not required), Sensitive information| 

 ## Three. example of Input Component Config 

 * vuex-input 

 ```text 
 "fieldName": { 
    "label": "versionNum", 
    "type": "vuex-input", 
    "desc": "Level 3 versionNum, for example: 1.0.1", 
    "required": true 
 } 
 ``` 

 * name select 

 ```text 
 "fieldName": { 
    "label": "To", 
    "type": "user-input", 
    "desc": "Only The current Project member can be Fill In in" 
 } 
 ``` 

 * atom-checkbox 

 ```text 
 "fieldName": { 
    "label": "", 
    "type": "atom-checkbox", 
    "text": "Rebuild required", 
    "desc": "XXX" 
 } 
 ``` 

 * selector/select-input/devops-select 
  * The list of options is setting in task.json 

    ```text 
    "fieldName":{ 
        "label": "Input Name", 
        "type": "selector", 
        "options":[ 
            { 
                "id":"video", 
                "name":"Video" 
            }, 
            { 
                "id":"website", 
                "name":"Website" 
            } 
        ] 
    } 
    ``` 

  * The list of options is obtained from the interface 
    * setting specification: specified by url, paramId, paramName and dataPath of optionsConf 

      ```text 
      "optionsConf": { 
            "url": "",         #Get API link for options list data 
            "dataPath": "",    #The path in the API Return body json where the options list data is located. If this Field is not present, it defaults to data. example: data.detail.list 
            "paramId": "",     #id Name of each options data 
            "paramName": ""    #name Name of each options data 
        } 
      ``` 

      * URL supports two types: 
        * BK-CI built-in service 
        * Third-party API for accessing BlueKing Gateway 
      * URL Return specification: Return data in Json format 

        * status: whether the Operation is Success. 0: successful; non-0 failed 
        * data: options list data.  You can specify the location path, such as data.detail.list 
        * The naming of the options ID and option name fields in data is not mandatory, and can correspond to the paramId and paramName in the setting 
        * message: Error Message when status is not 0 

        ```text 
        { 
            "status": 0, 
            "data": [ 
                { 
                    "optionId": "", 
                    "optionName": "" 
                } 
            ] 
        } 
        ``` 

      * setting example 

      ```text 
      "fieldName":{ 
            "label": "Input Name", 
            "type": "selector", 
            "optionsConf": { 
                "url": "http://xxx-test.com/prod/testnet", 
                "paramId": "optionId", 
                "paramName": "optionName" 
            } 
        } 
      ``` 
 * atom-checkbox-list List of multiple 

 ```text 
 "fieldName":{ 
    "label": "multiple list", 
    "type": "atom-checkbox-list", 
    "list": [ 
        { 
            "id": "php", 
            "name": "php", 
            "disabled": true, 
            "desc": "PHP is OK language in the world" 
        }, 
        { 
            "id": "python", 
            "name": "python", 
            "disabled": false, 
            "desc": "Python is OK language in the world" 
        } 
    ] 
 } 
 ``` 

 * time-picker date select 

 ```text 
 "fieldName":{ 
    "label": "date select", 
    "type": "time-picker", 
    "startDate": 1559555765, 
    "endDate": 1577894399000, 
    "showTime": false 
 } 
 ``` 

 * Tips Tips 

 ```text 
 "tipTest": { 
      "label": "", 
      "type": "tips", 
      "tipStr": "This is a XXX system, welcome to experience.  [click](www.baidu.com)" 
 } 
 ``` 

 * parameter Indefinite Parameter list 

 ```text 
 "params":{ 
  "label": "subPipeline Parameter", 
  "type": "parameter", 
  "required": false, 
  "desc": "bring in Run Parameter of subPipeline", 
  "param": { 
    "paramType": "url",                                // parameters is obtained from the url or directly take the list value, can be url or list 
    "url": "XXXX",                                     //When paramType is url, Access from API 
    "urlQuery":{ 
      "projectId": "","subPip": "" 
    }, 
    "parameters": [                                    //get Access from here when paramType is list 
      { 
        "id": "parameterId",                           //Unique ID of the row 
        "key": "abc", 
        "keyDisable": false,                           //control whether it can be edit 
        "keyType": "input",                            Can be input or select 
        "keyListType": "url",                          //Get list method, can be url or list 
        "keyUrl": "",                                  // type is selected 
        "keyList": [ { "id":"id", "name":"name" } ], // type is select works, need to have id and name Field 
        "keyMultiple": false,                          // select whether to select multiple 
        "value": "ddd", 
        "valueDisable": false, 
        "valueType": "input",                          Can be input or select 
        "valueListType": "url",                        //Get list method, can be url or list 
        "valueUrl": "",                                // type is selected 
        "valueList":[ { "id": "id", "name":"name" } ], // type is the select function 
        "valueMultiple: false                             // select whether to select multiple 
      } 
    ] 
  } 
 } 
 ``` 

 * enum-input radio 

 ```text 
 "fieldName_1":{ 
    "label": "radio", 
    "type": "enum-input", 
    "list": [ 
        { 
            "value": "php", 
            "label": "php" 
        }, 
        { 
            "value": "python", 
            "label": "python" 
        } 
    ] 
 } 
 ``` 

 ## Four. Display/Hide setting Based on Conditions 

 * Specified by the rely attribute in the Input Field definition, rely has two attributes: 
  * operation: the relationship between multiple conditions, and, or, not 
  * expression: conditional Expression 
 * The operation Field supports Three values: 
  * AND 
  * OR 
  * NOT 
 * Full match is supported, and the expression attribute is: 
  * key: Field Name 
  * value: Field value 
 * Regular is supported. In this case, the expression attribute is: 
  * key: Field Name 
  * regex: Regular Expression 
 * example: 

 Display current field when Field inputField\_1 value is true and inputField\_2 value ends with.apk, otherwise Hide current field 

 ```text 
 "fieldName":{ 
    ... 
    "rely": { 
        "operation": "AND", 
        "expression": [ 
            { 
                "key": "inputField_1", 
                "value": true 
            }, 
            { 
                "key": "inputField_2", 
                "regex": ".*\\.  apk$" 
            } 
        ] 
    } 
    ... 
 } 
 ``` 

