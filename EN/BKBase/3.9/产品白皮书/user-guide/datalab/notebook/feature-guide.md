## 功能指南

### 离线文件上传

#### 功能介绍

Notebook 内提供离线文件上传功能，支持上传 CSV 文件到平台，便捷的在 Notebook 中读取 CSV 文件内容生成 Pandas DataFrame 进行数据分析操作，并能基于 DataFrame 数据生成结果表。

#### 使用教程

##### 进行文件上传

![](../../../assets/datalab/notebook/feature-guide/file_upload.png)

![](../../../assets/datalab/notebook/feature-guide/file_upload2.png)



##### 查看数据源 id 和文件名

![](../../../assets/datalab/notebook/feature-guide/file_upload3.png)



##### 文件加载进 Notebook（上传成功后的 CSV 文件存储在 HDFS 集群中，如需在 Notebook 中使用，需先将文件加载进 Notebook）

```python
DataSet.download_file(raw_data_id, file_name)
"""
:param raw_data_id: 数据源 id
:param file_name: 文件名

:return: 执行结果，成功或失败，并附带文件使用示例
"""
```

![](../../../assets/datalab/notebook/feature-guide/download_file.png)



##### 展示加载进 Notebook 的文件列表

```python
DataSet.show_notebook_file()
"""
:param raw_data_id: 数据源 id（选填）

:return: 文件列表表格展示
"""
```

![](../../../assets/datalab/notebook/feature-guide/show_notebook_file.png)



##### 读取 CSV 文件生成 Pandas DataFrame 

```python
import pandas as pd
df = pd.read_csv('/files/524829/admin_1608602248.csv', encoding='utf-8-sig')
```

![](../../../assets/datalab/notebook/feature-guide/read_csv.png)



##### 基于 DataFrame 数据生成临时结果表

```python
ResultTable.create(dataframe, result_table_id)
"""
:param dataframe: pandas dataframe
:param result_table_id: 创建的结果表名

:return: 执行结果，成功或失败
"""
```

![](../../../assets/datalab/notebook/feature-guide/create.png)



##### 后续处理

临时结果表创建完成后，用户即可对结果表按照平台提供的指令进行相应处理，数据查询参考 [BKSQL 语法](./bksql.md)，数据更新参考 [Notebook 指令集](./command.md)。



### Notebook 生成报告

#### 功能介绍

Notebook 支持生成报告，用户可以基于 Notebook 内容生成可分享的报告。在项目下生成的报告，可以将 URL 分享给项目成员浏览；个人下生成的报告只能自己访问。

#### 使用教程

##### 点击生成报告

![](../../../assets/datalab/notebook/feature-guide/generate_report.png)

![](../../../assets/datalab/notebook/feature-guide/generate_report2.png)

![](../../../assets/datalab/notebook/feature-guide/generate_report3.png)



##### 浏览报告内容

![](../../../assets/datalab/notebook/feature-guide/report.png)



##### Tips：大纲编写方式

![](../../../assets/datalab/notebook/feature-guide/outline.png)

![](../../../assets/datalab/notebook/feature-guide/outline2.png)

![](../../../assets/datalab/notebook/feature-guide/outline3.png)

