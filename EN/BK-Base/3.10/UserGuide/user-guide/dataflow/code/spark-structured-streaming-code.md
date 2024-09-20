# Spark Structured Streaming Code function introduction
In order to satisfy users' complex business logic data processing, we have added the Code function based on the currently popular computing engine framework in the industry. This article mainly introduces the use of the Spark Structured Streaming Code function.

## manual
- Spark Structured Streaming Code node input currently supports multiple real-time data sources and real-time computing nodes, and can be configured with a result table output.
- Since Spark Structured Streaming Code is a real-time calculation, first drag a real-time data source, and then drag the Spark Structured Streaming Code node to connect behind the data source.

   ![](../../../assets/dataflow/code/spark_structured_streaming_code/spark_structured_streaming_code1.png)

- Double-click the code node to enter the configuration page, select a familiar programming language, and write data processing code. It supports passing parameters into the code, and the parameters are separated by spaces.

   ![](../../../assets/dataflow/code/spark_structured_streaming_code/spark_structured_streaming_code2.png)
    
- Configure data output. Configure the output table name, Chinese name, and output field information in order. One field needs to be specified in the field as the data time field (event time), and it must be a 13-digit timestamp. If not specified, The current time is used as the data time.

   ![](../../../assets/dataflow/code/spark_structured_streaming_code/spark_structured_streaming_code3.png)
  
- The advanced configuration includes the Savepoint parameter, which is Spark's checkpoint, which is used for automatic recovery of task failures and is enabled by default. Checkpoint details: https://spark.apache.org/docs/2.4.4/structured-streaming-programming-guide.html#recovering-from-failures-with-checkpointing

   ![](../../../assets/dataflow/code/spark_structured_streaming_code/spark_structured_streaming_code4.png)

## Development instructions
In order to allow users to focus on data logic development, the platform encapsulates the functions of data input and data output, and users only need to implement data logic in the code. The code function supports the development language <font color="#dd0000">**python version 3.6.9 or above**</font>

#### Sample code

- The data processing code template is to select the ip field and parameters of one of the data sources and then splice them together to output. The data processing class is spark_structured_streaming_code_transform and cannot be modified. The example is as follows:

```python
# -*- coding: utf-8 -*-

# python version is 3.6.9
# Please do not modify the data processing class name and method name in case the developed Code node is unavailable
class spark_structured_streaming_code_transform:
    
     def __init__(self, user_args, spark):
         self.user_args = user_args
         self.spark = spark
    
     # Data processing, an example is to select all fields of the input table and output
     # @param inputs stores the data source and its field names
     def transform(self, inputs):
         input_df = inputs["591_test_flink_code_node_1"]
         output_df = input_df.select("ip")
         return {"591_spark_structured_streaming_code_demo": output_df}
    
     # Output mode: complete, append, update
     def set_output_mode(self):
         return {"591_spark_structured_streaming_code_demo": "append"}

```

#### Sample configuration

In the example, the task is configured with two parameters. The first parameter user_args[0] is obtained, and the second parameter user_args[1] is obtained. The parameter types are all String. The parameter configuration is as follows:

![](../../../assets/dataflow/code/spark_structured_streaming_code/spark_structured_streaming_code_args.png)

The input table 591_test_flink_code_node_1 has a field ip, and the output table 591_spark_structured_streaming_code_demo also has a field ip. The configuration is as follows:

![](../../../assets/dataflow/code/spark_structured_streaming_code/spark_structured_streaming_code5.png)



#### Sample code, configuration display diagram

![](../../../assets/dataflow/code/spark_structured_streaming_code/spark_structured_streaming_code6.png)



## Precautions
- Spark Structured Streaming uses Spark version 2.4.4
- The data input and data output information in the code must be consistent with the input and output information in the basic configuration of the code node
- The current development language version is python 3.6.9