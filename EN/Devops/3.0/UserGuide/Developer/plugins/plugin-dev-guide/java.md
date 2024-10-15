 # Java Develop Plugin Guide 

 ## One. The overall structure of the project is as follows 

 ```text 
 |- pipeline-plugin 
    |- bksdk   Plugin sdk 
    |- demo    Plugin Sample, you can Revise the project name and internal logic to your customize 
 ``` 

 ## Two. How to Develop Plugin 

 > For example, see [plugin-demo-java](https://github.com/ci-plugins/plugin-demo-java) 

 * Create a Plugin Code project 

  The Plugin Code recommended to be Manage uniformly in the enterprise. 
  You can contact the Official website of BlueKing to put the general open source Plugin under [TencentBlueKing](https://github.com/TencentBlueKing) for more user to use 

 * Revise the package to a recognizable name, which is recommended to be consistent with the Plugin ID 
 * Implement Plugin functionality 
 * Specification: 
  * [Develop Plugin Specification](../plugin-dev-standard/plugin-specification.md) 
  * [Plugin Config Specification](../plugin-dev-standard/plugin-config.md) 
    * The Plugin front-end can be setting not only approve task.json, but also customize: [customize Plugin UI Interaction Guide](../plugin-dev-standard/plugin-custom-ui.md) 
  * [atomOutput specification](../plugin-dev-standard/plugin-output.md) 
  * [Plugin Error Code specification](../plugin-dev-standard/plugin-error-code.md) 
  * [Plugin Release Package Specification](../plugin-dev-standard/release.md) 

 ## Three. How to create a ZIP package required by the store 

 1. Enter pipeline-plugin directory execute "mvn clean package" command to package. 

 2. Enter the target file under the demo (the project directory where the Plugin logic is located) directory to get the ZIP package we need. 