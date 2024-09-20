 # NodeJS Plugin Execution Environment 

 The repository supports NodeJS plugin development. If you want to run NodeJS plugins on your build machine, you need to set the following: 

 - Install NodeJS 
  > It is recommended to install [node LTS version](https://nodejs.org/en/download/) to support more es features. 
 - If there is a dedicated npm source in the company, set the npm repository as the intranet version 

  ```bash 
    npm config set registry <intranet npm repository address>. 
  ``` 