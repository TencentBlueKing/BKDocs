 # Turbo in Pipeline 

 ## Preparation 

 If the environment select for your Pipeline is a **Self hosted agent**, you need to install the client on your machine with root auth in advance. 

```text
/bin/bash -c "$(curl http://< Your service domain name >/turbo-client/disttask/install.sh)"
```

  If your Pipeline select a BK-CI hosted agent, then **this step is not needed**. 

 ## Step1 Revise the Compilation Script 

 Suppose the original compiled Script is: 

```text
cd ${WORKSPACE}/master

./autogen.sh
./configure --disable-pump-mode

make clean
make -j all
```

 It can be seen that the commands in the previous section are doing some preparatory work. The actual compilation instructions are: 

```text
make -j all
```

 We only need to Revise this sentence to use the accelerator to execute the compilation instructions to get acceleration. 

```text
bk-booster -bt cc -p $TURBO_PLAN_ID --hook -a "make -j@BK_JOBS all"
```

 bk-booster is the accelerator provided by the Plugin to Start Up acceleration 

 The meaning of the Parameter in the command is 

 * -bt CC, specify the Scene as cc, for c/c++ compilation under linux. 
 * -p $TURBO\_PLAN\_ID, which specifies the scheme ID. In the Turbo Turbo Plugin, the selected scheme ID will be injected by default. 
 * --hook, enable the command hook, will auto hijack gcc/clang and other compilers, to achieve acceleration. 
 * -a "make -j@BK\_JOBS all" specifies the compile command to execute, where @BK\_JOBS is used as a placeholder and is auto Replace with the Recommended concurrency Quantity at Application Runtime. 

 ## Step2 Enable Pipeline and append the "**Turbo Turbo **" Plugin 

 ![](../../../assets/image%20%2867%29.png) 

 Note: Before this step, you need to append the pull Code Plugin 

 ## Step3 select a OK Acceleration Plan 

 ![](../../../assets/image%20%2860%29.png) 

 ## Step4 setting Compilation Script 

 You can use file Manage to compile Script and submit them to the Code Repository. You only need to Fill In the relative path of the script file in the Pipeline: 

 ![](../../../assets/image%20%2861%29.png) 

 You can also setting the build Script into the Plugin: 

![](../../../assets/image%20%2856%29.png)



