 # NodeJS Develop Plugin Guide 

 ## Develop Plugin Framework 

 **One. The overall structure of the Plugin Code project is as follows:** 

 **Two. How to Develop Plugin:** 

 > Reference 

 * create a Plugin Code project 

  The Plugin Code recommended to be Manage uniformly in the enterprise. 
  You can contact the Official website of BlueKing to put the general open source Plugin under [TencentBlueKing](https://github.com/TencentBlueKing) for more user to use 

 * Implement Plugin functionality 
 * Specification: 
  * [Develop Plugin Specification](../plugin-dev-standard/plugin-specification.md) 
  * [Plugin Config Specification](../plugin-dev-standard/plugin-config.md) 
    * The Plugin front-end can be setting not only approve task.json, but also customize: [customize Plugin UI Interaction Guide](../plugin-dev-standard/plugin-custom-ui.md) 
  * [atomOutput specification](../plugin-dev-standard/plugin-output.md) 
  * [Plugin Error Code specification](../plugin-dev-standard/plugin-error-code.md) 
  * [Plugin Release Package Specification](../plugin-dev-standard/release.md) 

 **Three. How to package and Release:** 

 1. Enter the root directory of the Plugin Code project 
 2. execute the package command package 
 3. add file anywhere. Name example: release\_pkg = <Your Plugin ID>\_release 
 4. Copy the execute package produced in Step 2 to <release\_pkg> 
 5. append the task.json file to the task.json under <release\_pkg> See the example, setting According to Plugin function. 

   * [Plugin Config Specification](../plugin-dev-standard/plugin-config.md) 
   * example of task. json: 

   ```text 
   { 
       "atomCode": "demo", 
       "execution": { 
           "language": "nodejs", 
           "packagePath": "",             # Relative path of Plugin install package in Release package 
           "demands": [ 
               ""   # installCommand that need to be execute before the Plugin is Start Up, in order 
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

 6. In the <release\_pkg> directory, type all the file into `ZIP` package. 

 example of `ZIP` package structure: 

 ```text 
 |- demo_release.zip         # Release Package 
   |-     # Plugin execute Package 
   |- task.json            # Plugin Config file 
 ``` 

 After the packaging is complete, you can Test or publish the plug-in in the Plugin workbench 