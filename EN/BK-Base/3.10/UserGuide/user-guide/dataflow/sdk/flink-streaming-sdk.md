# Flink streaming SDK function introduction
In order to meet users' complex business logic data processing, we have added SDK functions based on the currently popular computing engine framework in the industry. This article mainly introduces the use of Flink streaming SDK functions.

## manual
- Flink streaming sdk node input currently supports multiple real-time data sources and real-time computing nodes, and can be configured with a result table output.
- Since Flink streaming is a real-time calculation, first drag a real-time data source, and then drag the Flink streaming sdk node to connect it behind the data source.

   ![](../../../assets/dataflow/flink_streaming_sdk_overview.png)

- Double-click the sdk node to enter the configuration page, select the programming language, configure the data output (see the next step for detailed configuration), upload your code package (jar package), specify the program entrance, support passing parameters into the code, the parameters are separated by spaces.

   ![](../../../assets/dataflow/flink_streaming_sdk_node.png)

- Output editing configuration, configure the output table name, output Chinese name, and field information in order. You need to specify a field in the field as the data time field (event time). If not specified, the current time will be used as the data time.

   ![](../../../assets/dataflow/flink_streaming_sdk_output.png)

- The advanced configuration includes two parameters: Checkpoint and Savepoint. Checkpoint is enabled by default and is used for automatic recovery of task failures. Savepoint is optional and is used to ensure data consistency when the task is stopped and started again.

   ![](../../../assets/dataflow/flink_streaming_sdk_advanced.png)

## Development instructions
In order to allow users to focus on data logic development, the computing platform encapsulates the functions of data input and data output, and users only need to implement data logic in the code. The sdk function supports development language <font color="#dd0000">**Java 8 or above**</font>

### Java Development Notes

#### Install sdk dependency package

You need to install the sdk dependency package in the local development environment and set the maven source to mirrors.tencent.com. For details, please refer to: <http://mirrors.tencent.com/#/document/maven>

```xml
<dependencies>

     <dependency>
     <groupId>com.tencent.bkdata</groupId>
     <artifactId>bkdata-dataflow-sdk</artifactId>
     <version>1.0.0</version>
     </dependency>

     <dependency>
         <groupId>org.apache.flink</groupId>
         <artifactId>flink-streaming-java_2.11</artifactId>
         <version>1.9.1</version>
         <scope>provided</scope>
     </dependency>

</dependencies>
```

#### Development specifications

- The entry class must inherit the FlinkBasicRuntime class to implement. The basic example of FlinkBasicRuntime is as follows:

```java
import com.tencent.blueking.dataflow.common.api.FlinkBasicRuntime;
import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.types.Row;
import java.util.Map;


public class Example extends FlinkBasicRuntime {

   @Override
   public Map<String, DataStream<Row>> transform(Map<String, DataStream<Row>> input) {
     //Write specific logic here
     return null;
   }

}
```

#### Development Example

Connect the two upstream nodes, corresponding to the input real-time result tables 591_f2691_s_01 and 591_f2691_s_02. The output fields of the configuration result table 591_f2691_fs_02 are long_field, int_field, string_field and double_field, as shown below:

![Data input](../../../assets/dataflow/flink_streaming_sdk_example1_node.png)

![Data output configuration](../../../assets/dataflow/flink_streaming_sdk_example1_output.png)

In the SDK code logic, users can perform values and calculations based on the input result table. For 591_f2691_s_01, its field information is as follows:

![](../../../assets/dataflow/flink_streaming_sdk_example1_intput.png)

##### Built-in functions

To facilitate users to use Flink functions, we provide several built-in functions defined in the base class `FlinkBasicRuntime`:

```java
/**
   * Get the index of the field in the dataStream data table based on the field name
   * @param dataStream
   * @param fieldName
   * @return
  */
public int getFieldIndexByName(DataStream<Row> dataStream, String fieldName);
```

```java
/**
   * Get the Flink StreamExecutionEnvironment running environment object
   * @return
  */
public StreamExecutionEnvironment getEnv();
```

```java
/**
   * Get the Flink StreamTableEnvironment running environment object
   * @return
  */
public StreamTableEnvironment getTableEnv();
```

##### Code Example

**Code Example 1:**

```java
import com.tencent.blueking.dataflow.common.api.FlinkBasicRuntime;
import org.apache.flink.api.common.functions.MapFunction;
import org.apache.flink.api.common.typeinfo.BasicTypeInfo;
import org.apache.flink.api.common.typeinfo.TypeInformation;
import org.apache.flink.api.java.typeutils.RowTypeInfo;
import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.types.Row;
import java.util.HashMap;
import java.util.Map;


public class Example extends FlinkBasicRuntime {

   /**
    * data processing
    * @param input Dictionary to store the data source, key is the data source table name ID, value is the Flink streaming data structure corresponding to the data source DataStream<Row>
    * @return returns the dictionary storing the result data. The key is the output table name, and the value is the data structure DataStream<Row> corresponding to the output table. The fields output here must be the same as the node output configuration.
    */
   @Override
   public Map<String, DataStream<Row>> transform(Map<String, DataStream<Row>> input) {

     // 1. Initialize and return data object
     Map<String, DataStream<Row>> output = new HashMap<String, DataStream<Row>>();
// 2. Construct the result table return type list
     TypeInformation<?>[] rowType = new TypeInformation<?>[]{
         BasicTypeInfo.DOUBLE_TYPE_INFO,
         BasicTypeInfo.STRING_TYPE_INFO,
         BasicTypeInfo.INT_TYPE_INFO,
         BasicTypeInfo.LONG_TYPE_INFO
     };
     //Construct the result table return type corresponding to the field name. The field name corresponds to the above field type one-to-one. Note that it must be consistent with the node configuration information.
     String[] fieldNames = new String[]{
         "double_field",
         "string_field",
         "int_field",
         "long_field"
     };

     // 3. Write specific conversion logic and output datastream
     // The sample code only takes the field at the specified position and assigns it to the specified position in the output result table.
     DataStream<Row> inputDataStream = input.get("591_f2691_s_01");
     int doubleFieldIndex = this.getFieldIndexByName(inputDataStream, "double_field");
     int stringFieldIndex = this.getFieldIndexByName(inputDataStream, "string_field");
     int intFieldIndex = this.getFieldIndexByName(inputDataStream, "int_field");
     int longFieldIndex = this.getFieldIndexByName(inputDataStream, "long_field");
     DataStream<Row> newOutput = inputDataStream.map(new MapFunction<Row, Row>() {
       @Override
       public Row map(Row row) {
         Row ret = new Row(4);
         ret.setField(0, row.getField(doubleFieldIndex)); // Get the value of 591_f2691_s_01 field double_field
         ret.setField(1, row.getField(stringFieldIndex)); // Get the value of 591_f2691_s_01 field string_field
         ret.setField(2, row.getField(intFieldIndex)); // Get the value of 591_f2691_s_01 field int_field
         ret.setField(3, row.getField(longFieldIndex)); // Get the value of 591_f2691_s_01 field long_field
         return ret;
       }
     }).returns(new RowTypeInfo(rowType, fieldNames));

     // 4. Return the output result. The table name and field information must be consistent with the configuration of the output information.
     output.put("591_f2691_fs_02", newOutput);
     return output;
   }

}
```

- Corresponding diagram of code and configuration in the above example:

![](../../../assets/dataflow/flink_streaming_sdk_example.png)

**Code Example 2:**

​ This example uses custom program parameters and uses SQL to illustrate.

- How to use program parameters

![](../../../assets/dataflow/flink_streaming_args.png)

The program parameters args are placed in the parent class FlinkBasicRuntime, so they are used as follows:
```java
import com.tencent.blueking.dataflow.common.api.FlinkBasicRuntime;
import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.types.Row;
import java.util.Map;


public class UserMain extends FlinkBasicRuntime {

   @Override
   public Map<String, DataStream<Row>> transform(Map<String, DataStream<Row>> input)
     //The current value is 100
     String arg0 = this.args.get(0);
     ...
   }

}
```

- Node configuration and writing code

If the entry class is UserMain, the project directory is as follows:

![](../../../assets/dataflow/flink_streaming_sdk_project_example.png)

Then fill in the program entry class as follows:

![](../../../assets/dataflow/flink_streaming_sdk_args.png)

- specific code

```java
import com.tencent.blueking.dataflow.common.api.FlinkBasicRuntime;
import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.table.api.Table;
import org.apache.flink.table.api.java.StreamTableEnvironment;
import org.apache.flink.types.Row;
import java.util.HashMap;
import java.util.Map;


public class UserMain extends FlinkBasicRuntime {

   /**
    * data processing
    * @param input Dictionary to store the data source, key is the data source table name ID, value is the Flink streaming data structure corresponding to the data source DataStream<Row>
    * @return returns the dictionary storing the result data. The key is the output table name, and the value is the data structure DataStream<Row> corresponding to the output table. The fields output here must be the same as the node output configuration.
    */
   @Override
   public Map<String, DataStream<Row>> transform(Map<String, DataStream<Row>> input) {

     // 1. Initialize and return data object
     Map<String, DataStream<Row>> output = new HashMap<String, DataStream<Row>>();

     // 2. Register SQL table
     DataStream<Row> inputDataStream = input.get("591_f2717_s_01");
     //Define the table name. Note that it cannot start with a number.
     String tableName = "table_591_f2717_s_01";
     StreamTableEnvironment tableEnv = this.getTableEnv();
     tableEnv.registerDataStream(tableName, inputDataStream);

     // 3. Get program parameters
     String arg0 = this.args.get(0);

     // 4. Execute SQL and add constant value as new field
     //The final output fields are double_field, string_field, int_field, long_field, arg0_field
     String sql = "select double_field, string_field, int_field, long_field, '" + arg0 + "' as arg0_field from " + tableName;
     Table commonTable = tableEnv.sqlQuery(sql);

     // 5. Return the output result. The table name and field information must be consistent with the configuration of the output information.
     DataStream<Row> newOutput = tableEnv.toAppendStream(commonTable, commonTable.getSchema().toRowType());
     output.put("591_f2691_fs_03", newOutput);
     return output;
   }
}
```

The above result table output needs to correspond to the configuration of the node:

![](../../../assets/dataflow/flink_streaming_sdk_sql_example_output.png)

- Packaging method

Pack it with the following command:

```shell
$ mvn package
$ ls target/*.jar
target/your.jar
```

## Precautions
- The Flink version used by Flink streaming is 1.9.1
- The data input and data output information in the code must be consistent with the input and output information in the basic configuration of the SDK node
- The current development language version is Java 8 or above.