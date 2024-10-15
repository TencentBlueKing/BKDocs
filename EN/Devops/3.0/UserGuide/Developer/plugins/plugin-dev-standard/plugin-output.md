 # atomOutput specification 

 * After the Plugin is execute, the Output var can be passed to the downstream step Pipeline, or Archive to the warehouse and report to outputReport 
 * The Output information is specified by how the file is written, and the file path and name are specified by system Env Variables 
 * The Output information format is Description in detail as follows: 

 ```text 
 { 
    "status": "",      # Plugin execute result, the value can be success, failure 
    "message": "",     # Description of Plugin execute result, markdown format is supported 
    "errorType": 3,    # Plugin Error Type, int, 1 indicates user Usage (invalid Parameter, etc.), 2 indicates dependent third-party platform problem, 3 indicates plugin logic problem 
    "errorCode": 0,    # Plugin Error Code, int, used to analyze the quality of plugins based on the error code 
    "type": "default", # output data template type, used to specify the output data parsing and warehousing method.  Currently supports default 
    "data": {          # The data format of the default template is as follows, and each Output Field should be definition in task.json first 
        "outVar_1": { 
            "type": "string", 
            "value": "testaaaaa" 
        }, 
        "outVar_2": { 
            "type": "artifact", 
            "value": ["file_path_1", "file_path_2"] #absolute path of files, after specifying, agent auto Archive these files to the repository 
        }, 
        "outVar_3": { 
            "type": "report", 
            "reportType":"", # report type Internal Built-in report, THIRDPARTY third-party link, default is Internal 
            "label": "",      # report aliasName, used to identify the current report in the outputReport interface 
            "path": "",       # reportType=INTERNAL, report the absolute path of the directory.  Pay attention to planning report path, and all content under the directory will be archived together as the report link file 
            "target": "",     # When reportType=INTERNAL, report the entry Filename 
            "url": ""         # report link when reportType=THIRDPARTY, used when the report is accessible approve url 
        } 
    } 
 } 
 ``` 

 * Three types of Type Of Data are supported in output data: 
  * string: string 
    * length cannot exceed 4k characters 
  * artifact: artifactory 
    * Support for multiple artifactory 
    * Each artifactory specifies a local absolute path 
  * Report: report 
    * There are two types of report: built-in reports, third-party link 
    * report file not recommended to be placed directly in the root directory. If Other files in the root directory, such as Code Repository, will be uploaded as related files of the report. It is recommended to create a directory to save, for example, path=${{WORKSPACE}}/report, target=result\_report.html 