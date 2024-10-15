 # Use Pipeline triggerType-manual execute/Cron/Remote triggers, etc. 

 The triggerType is used approve select different type of Plugin under Trigger 

 *   manual execute 

    The default triggerType for createPipeline is manual execute. Here, simply append One stage\ 
    Manual Plugin: manual execute Pipeline, which means that after the pipeline is established, you can Click To Save in the upper right corner and manually click the execute pipeline button 

 ![](../../../assets/image-20211209205014251.png) 

 *   Cron 

    append Timer Plugin, definition crontab Expression 

 ![](../../../assets/image-20211209211036492.png) 



 view the pipelinesHistory, you can see that Pipeline is auto timed to execute One per minutes 

 ![](../../../assets/image-20211209211239418.png) 

 *   Remote triggers 

    append Remote Plugin-can be Remote triggers approve execute a command 

    copy the example command. If trigger has a definition var, the command line will auto Generate a sample with variable Parameter 

 ![](../../../assets/image-20211209211650003.png) 

 execute curl command from the command line 

 ![](../../../assets/image-20220301101202-tNslA.png) 

 The Execution record can be view in the Pipeline pipelinesHistory 

 ![](../../../assets/image-20211209211547148.png) 