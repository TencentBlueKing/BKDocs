 # Python Plugin Execution Environment 

 The repository supports the Develop Python plugin. If you want to run Python plugins on your build machine, you need to set the following: 

 - install python 
  - Since Python2 is deprecated, it is recommended to install Python 3.6. 
  - The plugin needs to be compatible with both python2 and python3, so the version of python installed in the build environment has little effect. 
 - Install the latest version of the pip tools. 
 - If there is a dedicated pip source in the enterprise, please set the pip source to 

    ```[global] 
    index-url = <internal pip source 
    extra-index-url = <alternate pip source 
    timeout = 600 

    [install] 
    trusted-host = <host of pip source 
    ``` 

  - Setup step (Linux example) 
    - Login to the machine as the user who will install the BK-CI agent 
      > The user setting pip must be the same as the user running the BK-CI agent, otherwise the configuration will not take effect. 
      > Execute ps -ef| The grep devops command Confirm the user who is running the BK-CI Agent 
    - vi ~/.pip/pip.conf, append the above setting, note that the line break cannot be\r\n 
    - Save the configuration 
    - Restart the BK-CI Agent 