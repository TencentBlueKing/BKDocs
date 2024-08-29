# Flink streaming SDK 功能介绍
为了能够满足用户复杂的业务逻辑数据处理，我们基于目前业界比较流行的计算引擎框架增加了 SDK 功能，本文主要介绍 Flink streaming SDK 功能的使用。

## 使用流程
- Flink streaming sdk 节点输入目前支持多个实时数据源和实时计算节点，可配置一个结果表输出。
- 由于 Flink streaming 属于实时计算，首先拖一个实时数据源，然后拖 Flink streaming sdk 节点接在数据源后面。

  ![](../../../assets/dataflow/flink_streaming_sdk_overview.png)

- 双击 sdk 节点进入配置页面，选择编程语言，配置好数据输出(详细配置查看下一步)，上传好你的代码包(jar 包)，指定好程序入口，支持向代码中传入参数，参数以空格分隔。

  ![](../../../assets/dataflow/flink_streaming_sdk_node.png)

- 输出编辑配置，按照顺序配置输出的表名、输出中文名、字段信息，其中需要在字段中指定一个字段作为数据时间字段（event time），如不指定，则以当前时间作为数据时间。

  ![](../../../assets/dataflow/flink_streaming_sdk_output.png)

- 高级配置中包含 Checkpoint 和 Savepoint 两个参数，其中 Checkpoint 是默认开启的，用于任务的故障自动恢复。Savepoint 是可以选择的，用于任务停止后再次启动时，保证数据的一致性。

  ![](../../../assets/dataflow/flink_streaming_sdk_advanced.png)

## 开发须知
为了使用户专注于数据逻辑开发，计算平台封装了数据输入和数据输出的功能，用户只需要在代码中实现数据逻辑即可。sdk 功能支持开发语言为 <font color="#dd0000">**Java 8 以上**</font>

### Java 开发须知

#### 安装 sdk 依赖包

需要在本地开发环境安装 sdk 依赖包，并将设置 maven 源为 mirrors.tencent.com，具体可参考：<http://mirrors.tencent.com/#/document/maven>

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

#### 开发规范

- 入口类必须要继承 FlinkBasicRuntime 类来实现，FlinkBasicRuntime 基本示例如下：

```java
import com.tencent.blueking.dataflow.common.api.FlinkBasicRuntime;
import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.types.Row;
import java.util.Map;


public class Example extends FlinkBasicRuntime {

  @Override
  public Map<String, DataStream<Row>> transform(Map<String, DataStream<Row>> input) {
    // 在此书写具体逻辑
    return null;
  }

}
```

#### 开发示例

连接两个上游的节点，对应输入实时结果表 591_f2691_s_01 和 591_f2691_s_02， 配置结果表 591_f2691_fs_02 的输出字段为 long_field、int_field、string_field 和 double_field，如下图：

![数据输入](../../../assets/dataflow/flink_streaming_sdk_example1_node.png)

![数据输出配置](../../../assets/dataflow/flink_streaming_sdk_example1_output.png)

在 SDK 代码逻辑中，用户可根据输入结果表进行取值和计算，对于 591_f2691_s_01，其字段信息如下：

![](../../../assets/dataflow/flink_streaming_sdk_example1_intput.png)

##### 内置函数

为方便用户使用 Flink 功能，我们提供在基类`FlinkBasicRuntime`中定义了若干内置函数：

```java
/**
  * 根据字段名称获取字段在 dataStream 数据表中的索引
  * @param dataStream
  * @param fieldName
  * @return
 */
public int getFieldIndexByName(DataStream<Row> dataStream, String fieldName);
```

```java
/**
  * 获取 Flink StreamExecutionEnvironment 运行环境对象
  * @return
 */
public StreamExecutionEnvironment getEnv();
```

```java
/**
  * 获取 Flink StreamTableEnvironment 运行环境对象
  * @return
 */
public StreamTableEnvironment getTableEnv();
```

##### 代码示例

**代码示例 1：**

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
   * 数据处理
   * @param input 存放数据源的字典，key为数据源表名ID，value为数据源对应的Flink streaming的数据结构 DataStream<Row>
   * @return 返回存放结果数据的字典，key为输出表名，value为输出表对应的数据结构 DataStream<Row>，这里输出的字段必须要和节点输出配置一样
   */
  @Override
  public Map<String, DataStream<Row>> transform(Map<String, DataStream<Row>> input) {

    // 1. 初始化返回数据对象
    Map<String, DataStream<Row>> output = new HashMap<String, DataStream<Row>>();

    // 2. 构建结果表返回类型列表
    TypeInformation<?>[] rowType = new TypeInformation<?>[]{
        BasicTypeInfo.DOUBLE_TYPE_INFO,
        BasicTypeInfo.STRING_TYPE_INFO,
        BasicTypeInfo.INT_TYPE_INFO,
        BasicTypeInfo.LONG_TYPE_INFO
    };
    // 构建结果表返回类型对应字段名称，字段名称和上述的字段类型一一对应，注意必须和节点配置的信息保持一致
    String[] fieldNames = new String[]{
        "double_field",
        "string_field",
        "int_field",
        "long_field"
    };

    // 3. 书写具体转换逻辑，输出 datastream
    // 示例代码仅取指定位置字段并赋值到输出结果表指定位置
    DataStream<Row> inputDataStream = input.get("591_f2691_s_01");
    int doubleFieldIndex = this.getFieldIndexByName(inputDataStream, "double_field");
    int stringFieldIndex = this.getFieldIndexByName(inputDataStream, "string_field");
    int intFieldIndex = this.getFieldIndexByName(inputDataStream, "int_field");
    int longFieldIndex = this.getFieldIndexByName(inputDataStream, "long_field");      
    DataStream<Row> newOutput = inputDataStream.map(new MapFunction<Row, Row>() {
      @Override
      public Row map(Row row) {
        Row ret = new Row(4);
        ret.setField(0, row.getField(doubleFieldIndex));   // 取 591_f2691_s_01 字段 double_field 的值
        ret.setField(1, row.getField(stringFieldIndex));   // 取 591_f2691_s_01 字段 string_field 的值
        ret.setField(2, row.getField(intFieldIndex));	   // 取 591_f2691_s_01 字段 int_field 的值
        ret.setField(3, row.getField(longFieldIndex));	   // 取 591_f2691_s_01 字段 long_field 的值
        return ret;
      }
    }).returns(new RowTypeInfo(rowType, fieldNames));

    // 4. 返回输出结果，表名和字段信息必须和输出信息的配置保持一致
    output.put("591_f2691_fs_02", newOutput);
    return output;
  }

}
```

- 以上示例中代码和配置对应图：

![](../../../assets/dataflow/flink_streaming_sdk_example.png)

**代码示例 2：**

​	本示例使用自定义程序参数以及使用 SQL 的方式进行说明。

- 程序参数的使用方法

![](../../../assets/dataflow/flink_streaming_args.png)

程序参数 args 是放在了父类 FlinkBasicRuntime，所以使用方式如下：
```java
import com.tencent.blueking.dataflow.common.api.FlinkBasicRuntime;
import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.types.Row;
import java.util.Map;


public class UserMain extends FlinkBasicRuntime {

  @Override
  public Map<String, DataStream<Row>> transform(Map<String, DataStream<Row>> input) 
    // 当前值为 100
    String arg0 = this.args.get(0);
    ...
  }

}
```

- 节点配置及编写代码

假如入口类 UserMain，所在工程目录如下：

![](../../../assets/dataflow/flink_streaming_sdk_project_example.png)

那么程序入口类填写如下：

![](../../../assets/dataflow/flink_streaming_sdk_args.png)

- 具体的代码

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
   * 数据处理
   * @param input 存放数据源的字典，key为数据源表名ID，value为数据源对应的Flink streaming的数据结构 DataStream<Row>
   * @return 返回存放结果数据的字典，key为输出表名，value为输出表对应的数据结构 DataStream<Row>，这里输出的字段必须要和节点输出配置一样
   */
  @Override
  public Map<String, DataStream<Row>> transform(Map<String, DataStream<Row>> input) {

    // 1. 初始化返回数据对象
    Map<String, DataStream<Row>> output = new HashMap<String, DataStream<Row>>();

    // 2. 注册 SQL table
    DataStream<Row> inputDataStream = input.get("591_f2717_s_01");
    // 定义表名，注意不可以数字开头
    String tableName = "table_591_f2717_s_01";
    StreamTableEnvironment tableEnv = this.getTableEnv();
    tableEnv.registerDataStream(tableName, inputDataStream);

    // 3. 获取程序参数
    String arg0 = this.args.get(0);

    // 4. 执行 SQL，并增加常数值作为新字段
    // 最终输出字段为 double_field, string_field, int_field, long_field, arg0_field
    String sql = "select double_field, string_field, int_field, long_field, '" + arg0 + "' as arg0_field from " + tableName;
    Table commonTable = tableEnv.sqlQuery(sql);

    // 5. 返回输出结果，表名和字段信息必须和输出信息的配置保持一致
    DataStream<Row> newOutput = tableEnv.toAppendStream(commonTable, commonTable.getSchema().toRowType());
    output.put("591_f2691_fs_03", newOutput);
    return output;
  }
}
```

以上结果表输出，需对应节点的配置：

![](../../../assets/dataflow/flink_streaming_sdk_sql_example_output.png)

- 打包方式

通过以下命令打包：

```shell
$ mvn package
$ ls target/*.jar
target/your.jar
```

## 注意事项
- Flink streaming 使用的 Flink 版本为 1.9.1
- 代码中的数据输入和数据输出信息必须和 SDK 节点中基本配置中的输入、输出信息一致
- 当前开发语言版本分别为 Java 8 以上
