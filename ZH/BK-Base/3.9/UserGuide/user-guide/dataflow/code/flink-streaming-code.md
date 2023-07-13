# Flink Streaming Code 功能介绍
为了能够满足用户复杂的业务逻辑数据处理，我们基于目前业界比较流行的计算引擎框架增加了 Code 功能，本文主要介绍 Flink Streaming Code 功能的使用。

## 使用流程
- Flink Streaming Code 节点输入目前支持多个实时数据源和实时计算节点，可配置一个结果表输出。
- 由于 Flink Streaming 属于实时计算，首先拖一个实时数据源，然后拖 Flink Streaming Code 节点接在数据源后面。
  ![](../../../assets/dataflow/code/flink_streaming_code/flink_streaming_code1.png)

- 双击 code 节点进入配置页面，选择熟悉的编程语言，编写数据处理代码，支持向代码中传入参数，参数以空格分隔。
  ![](../../../assets/dataflow/code/flink_streaming_code/flink_streaming_code2.png)
    
- 配置数据输出，按照顺序配置输出的表名、中文名、输出字段信息，其中需要在字段中指定一个字段作为数据时间字段（event time），而且必须为 13 位的时间戳，如不指定，则以当前时间作为数据时间。
  ![](../../../assets/dataflow/code/flink_streaming_code/flink_streaming_code3.png)
  
- 高级配置中包含 Checkpoint 和 Savepoint 两个参数，其中 Checkpoint 是默认开启的，用于任务的故障自动恢复。Savepoint 是可以选择的，用于任务停止后再次启动时，保证数据的一致性。但是某些场景是不能使用的，详见：https://ci.apache.org/projects/flink/flink-docs-release-1.10/ops/state/savepoints.html
  ![](../../../assets/dataflow/code/flink_streaming_code/flink_streaming_code4.png)

## 开发须知
为了使用户专注于数据逻辑开发，平台封装了数据输入和数据输出的功能，用户只需要在代码中实现数据逻辑即可。code 功能支持开发语言为 <font color="#dd0000">**Java 8 以上**</font>

### Java 开发须知

##### 内置函数

为方便用户使用 Flink 功能，我们提供在基类`FlinkBasicRuntime`中定义了若干内置函数：

```java
/**
   * 根据字段名称获取字段在 dataStream 数据表中的索引， dtEventTimeStamp,localTime,dtEventTime 可使用
   * @param dataStream
   * @param fieldName
   * @return
   */
  public int getFieldIndexByName(DataStream<Row> dataStream, String fieldName)
```

```java
/**
   * 获取 Flink StreamExecutionEnvironment 运行环境对象
   * @return
   */
  public StreamExecutionEnvironment getEnv()
```

```java
/**
   * 获取 Flink StreamTableEnvironment 运行环境对象
   * @return
   */
  public StreamTableEnvironment getTableEnv()
```

#### 示例代码

- 数据处理代码模版是选取其中一个数据源的 ip 字段和参数拼接后输出。数据处理类 CodeTransform 继承 FlinkBasicRuntime 类来实现，示例如下：

```java
import com.tencent.blueking.dataflow.common.api.FlinkBasicTransform;
import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.types.Row;
import java.util.HashMap;
import java.util.Map;
import org.apache.flink.api.common.functions.MapFunction;
import org.apache.flink.api.common.typeinfo.BasicTypeInfo;
import org.apache.flink.api.common.typeinfo.TypeInformation;
import org.apache.flink.api.java.typeutils.RowTypeInfo;

/**
 * 请注意以下几点，以防开发的 Code 节点不可用
 * 1.jdk 版本为 1.8
 * 2.Flink 版本 为 1.10.1
 * 2.请不要修改数据处理类名 CodeTransform
 */
public class CodeTransform extends FlinkBasicTransform {

    /**
     * 数据处理，示例为将一个数据的所有字段选择，并输出
     * 
     * @param input 存放数据源的 Map，key 为数据源表名 id，value 为数据源对应的Flink streaming 的数据结构 DataStream<Row>
     * @return 返回存放结果数据的 Map，key 为输出表名，value 为输出表对应的数据结构 DataStream<Row>，输出的字段必须要和节点输出配置一样
     */
    @Override
    public Map<String, DataStream<Row>> transform(Map<String, DataStream<Row>> input) {
        
        // 数据输入
        DataStream<Row> inputDataStream0 = input.get("591_f1658_s_01");
        
        // 数据处理
        // 输出表字段名配置
        String[] fieldNames = new String[] {
            "ip"
        };
        
        // 输出表字段类型配置
        TypeInformation<?>[] rowType = new TypeInformation<?>[]{
            BasicTypeInfo.STRING_TYPE_INFO
        };
        
        // 获取数据源字段的index
        int index0 = this.getFieldIndexByName(inputDataStream0, "ip");
        
        // 将第一个数据源的所有字段赋值给输出表
        DataStream<Row> newOutput = inputDataStream1.map(new MapFunction<Row, Row>() {
            @Override
            public Row map(Row row) {
                Row ret = new Row(1);
                // 将 ip 字段值和第一个参数，第二个参数拼接；args.get(0) 直接获取第一个参数，获取的参数类型默认均为 String
                ret.setField(0, row.getField(index0) + " " + args.get(0) + " " + args.get(1));  
                return ret;
            }
        }).returns(new RowTypeInfo(rowType, fieldNames));
        
        // 数据输出
        Map<String, DataStream<Row>> output = new HashMap<>();
        output.put("591_demo1", newOutput);
        return output;     
    }
}

```

#### 示例配置

示例中任务配置了两个参数，获取第一个参数 args.get(0)，获取第二个参数 args.get(1)，参数类型均为 String, 参数配置如下图：
![](../../../assets/dataflow/code/flink_streaming_code/flink_streaming_code_args.png)

输入表 591_f1658_s_01 有一个字段 ip， 输出表 591_demo1 的字段也为 ip，配置如下图：
![](../../../assets/dataflow/code/flink_streaming_code/flink_streaming_code5.png)



#### 示例代码，配置展示图

![](../../../assets/dataflow/code/flink_streaming_code/flink_streaming_code6.png)



## 注意事项
- Flink streaming 使用的 Flink 版本为 1.10.1
- 代码中的数据输入和数据输出信息必须和 code 节点中基本配置中的输入、输出信息一致
- 当前开发语言版本分别为 Java 8
