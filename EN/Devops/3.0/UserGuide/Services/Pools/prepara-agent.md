 # Self hosted agent environment Preparation 

 BK-CI Pipeline Plugin are provided by Official or third-party Develop.  The Develop Plugin language supports Java, Python, NodeJs or Golang, and the execute depends on the environment. Before the Self hosted agent import BK-CI as Pipeline runs machine, it is necessary to prepare the environment in case the pipeline fail. 

 ## Preparing the Python Plugin execute environment 
 The store supports the Develop python Plugin. If you want to Run python plugins on your build machine, you need to set the following Set: 

 * install Python 
  * Since Python2 is going out of service, it is recommended to install Python 3.6. 
  * The Plugin needs to be compatible with python2 and python3, so the python version install in the execute environment has little effect 
 * install the The latest version of of pip tools 
 *   If there is a dedicated pip source in the enterprise, please Set the pip source 

    ``` 
    index-url = <internal pip source> 
    extra-index-url = <alternate pip source> 
    timeout = 600 

    [install] 
    trusted-host = <host of pip source> 
    ``` 

    * setting step (Linux as an example) 
      *   signIn the machine as the user who install the BK-CI Agent 

          > The user setting pip must be the same as the user Start Up BK-CI Agent, otherwise the configuration will not Take Effect. execute ps -ef| The grep devops command Confirm the user who Start Up the BK-CI Agent 
      * vi \~/.pip/pip.conf, append the above setting, note that the line break cannot be\r 
      * Save Configuration 
      * restart BK-CI Agent 

 ## Preparing the Nodejs Plugin execute environment 
 The store supports the Develop of NodeJS Plugin. If you want to Run NodeJS plugins on your build machine, you need to set the following Set: 

 *   install NodeJS 

    > It is recommended to install [node version](https://nodejs.org/en/download/) to support more es features. 
 *   If there is a dedicated npm source in the enterprise, setting npm repository as a intranet version 

    ``` 
      npm config set registry <intranet npm repository address> 
    ``` 