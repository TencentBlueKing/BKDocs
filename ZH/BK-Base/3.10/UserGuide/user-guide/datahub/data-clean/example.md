## 数据清洗 示例

### Demo1: json 类型数据清洗
若输入为标准的 json 格式，则可以利用 json 反序列化算法进行清洗配置

    {
         "code": "200",
         "message": "Not Found",
         "result": false,
         "data": {
              "co1": "val2-1",
              "co2": "val2-2",
              "time": "2020-07-27 12:00:00"
         },
         "errors": null
    }

清洗配置和输出结果如图所示：

![](./media/clean-e.g-1.png)

### Demo2: 字符串类型数据清洗
若输入为标准的字符串格式，则可以灵活利用取值，赋值，分割等算子

    中国|河北省|test|http://x.x.x.:9999/pulsar/tail/?dataId=101448&topic=persistent%3a%2f%2fpublic%2fdata%2f0720_pulsar_db55ddd5591-partition-0&serviceUrl=http%3a%2f%2f9.*.*.*%3a80%2f


若想取出例子中的 url 中所包含的关键信息，可以参考如图所示清洗配置：

![](./media/clean-e.g-2.png)
