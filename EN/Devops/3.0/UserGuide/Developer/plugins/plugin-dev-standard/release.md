 # Plugin Release Specification 
 
 # Release Specification 

 * The release package format is a ZIP file. 
 * The release package contains 
  * \[Required\] Plugin execute 
  * \[Required\] task.json 
  * \[optional\] frontend directory 
    * Directory for custom UI related file 

 ## Version Management Specification 

 * versionNum Manage follows the [Semantic Version](https://semver.org/) specification 
 * User can approve the\[versionNum latest\] mode to reference plugin in pipeline, and automatically use the latest version of under the specified major version number.  Please update the plugin according to the specification. 