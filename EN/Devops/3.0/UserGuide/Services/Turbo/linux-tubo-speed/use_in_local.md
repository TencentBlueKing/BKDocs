 # Using acceleration on Private build machines 

 ## Step1 ** First install the acceleration toolkit on the machine (execute by root)** 

```text
/bin/bash -c "$(curl http://<您的服务域名>/turbo-client/disttask/install.sh)"
```

 ## Step 2 Copy Acceleration Plan ID 

 You can get the ID on the view Protocol page: 

 ![](../../../assets/image%20%2862%29.png) 

 ## Step3 Use the acceleration tool to Start Up acceleration 

 for example the original compiled Script is: 

 ```text 
 make -j gamesvr 
 ``` 

 execute acceleration with the tools install in Step 1, in conjunction with the scenario ID in Step 2: 

 ```text 
 bk-booster -bt CC -p <ID copied in Step 2> --hook -a "make -j@BK_JOBS gamesvr" 
 ``` 

 The bk-booster is the accelerator provided by the Plugin to Start Up acceleration. 

 The meaning of the Parameter in the command is 

 * -bt CC, specify the Scene as cc, for c/c++ compilation under linux. 
 * -p&lt; Acceleration Plan ID&gt;, specifies the scenario ID. 
 * --hook, enable the command hook, will auto hijack gcc/clang and other compilers, to achieve acceleration. 
 * -a "make -j@BK\_JOBS gamesvr", which specifies the compile command to execute, where @BK\_JOBS is used as a placeholder and is auto Replace with the Recommended concurrency Quantity at Application Runtime. 