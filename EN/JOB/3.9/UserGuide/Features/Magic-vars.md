# Magic variable

"Magic variable" is a unique ability provided by the execution engine of the job platform. Through the analysis and processing of the associated parameters between job steps, it is provided in a special way for users to choose and use according to different consumption scenarios; it aims to help operation and maintenance in dealing with complex The multi-step context parameters can be more handy, providing more powerful capabilities to meet more imagination.

### Usage

   Used in the script, and needs to be declared in advance: `job_import {{variable name}}`
   After the declaration, also use the dollar symbol + braces: `${variable name}`

### where to use
   Currently only supported in the `shell` scripting language

### variable list
   - Get the value of a global variable of type `hostlist`

     ```bash
     # job_import {{global variable name for host list}}
    
     echo ${global variable name for host list}
     ```

     Output result (example):

     ```text
     0:10.1.1.100,1:20.2.2.200
     ```

     The output format is: `cloud region ID + colon + intranet IP`, multiple IP addresses are separated by commas

   - Get the list of hosts executed by the previous step

     ```bash
     # job_import {{JOB_LAST_ALL}}
     # Get a list of all execution host IPs in the previous step
    
     # job_import {{JOB_LAST_SUCCESS}}
     # Get the host IP list that was successfully executed in the previous step
    
     # job_import {{JOB_LAST_FAIL}}
     # Get the IP list of hosts that failed in the previous step
     ```

     The output format is the same as above: `cloud region ID + colon + intranet IP`, multiple IP addresses are separated by commas

   - Get the namespace variable value of other hosts
  
     ```bash
     # job_import {{JOB_NAMESPACE_ALL}}
     # Get aggregated values for all namespace variables
     echo ${JOB_NAMESPACE_ALL}
    
     # job_import {{JOB_NAMESPACE_ namespace variable name}}
     # Get the aggregated value of a namespace variable
     echo ${JOB_NAMESPACE_namespace variable name}
     ```

     Output result (example):
  
     ```bash
     ### The output of echo ${JOB_NAMESPACE_ALL} (assuming there are two global variables of namespace type ns_var1 and ns_var2):
     {"ns_var1":{"0:10.10.10.1":"xxxx","0:10.10.10.2":"yyyy","0:10.10.10.3":"zzzz"},"ns_var2":{"0 :20.20.20.1":"aaaa","0:20.20.20.2":"bbbb","0:20.20.20.3":"cccc","0:20.20.20.4":"dddd"}}
      
     ### output of echo ${JOB_NAMESPACE_namespace variable name}:
     {"0:10.10.10.1":"xxxx","0:10.10.10.2":"yyyy","0:10.10.10.3":"zzzz"}
     ```