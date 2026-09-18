# 任务日志查看
Flow 中任务的日志数据有助于任务开发同学查找和定位问题。在 Flow 界面中，可以通过日志界面查看和检索日志数据。

日志数据是由 Flow 中的计算任务在计算平台上运行输出的，日志数据按照以下不同维度的分类。

## 任务日志分类

- 按任务阶段分类：
  - 提交日志 - 任务提交阶段的日志
    - 对于离线任务（ Spark 任务），即为 Driver 端日志
    - 对于实时任务（ Flink 任务），即为任务调度启动任务的日志
  - 运行日志 - 任务运行阶段的日志
    - 对于离线任务（ Spark 任务），即为 Executor 端日志
    - 对于实时任务（ Flink 任务），即为 JobManger / TaskManager 端日志
- 按任务类型分类：
  - 离线任务日志 - Spark 任务日志
    - 计算角色 - Executor
  - 实时任务日志 - Flink 任务日志
    - 计算角色 - JobManager / TaskManager
- 按日志文件类型分类：
  - Log - log 文件，对应于计算平台中的 .log 后缀的日志文件【只在实时任务中存在】
  - Stdout - stdout 文件，对应于计算平台中的 stdout 日志文件
  - Stderr - stderr 文件，对应于计算平台中的 stderr 日志文件
  - Exception - exception 日志，对应于计算平台中的异常信息【只在实时任务中存在】

## 日志中的其他概念

- 执行记录：
  - 离线任务：离线任务在计算平台中是按照配置的时间规则来定期调度，每一次任务执行会产生一次执行记录。
  - 实时任务：由于实时任务长期运行，通常只对应一次执行记录（即最近一次），无需用户选择。
- 运行容器：
  - 任务在平台中运行时，是分布式运行在某些“容器”（ container ）中，每个容器中运行特定的计算逻辑，每个容器的日志数据独立存在。
  - 运行日志的查看和检索需要选择某个特定的容器。



### 日志查看

- 日志查看入口
  <img src="../../assets/dataflow/tasklog/tasklog_entry.png" alt="tasklog_entry" style="zoom:50%;" />

- 日志查看界面

  <img src="../../assets/dataflow/tasklog/tasklog_view.png" alt="tasklog_view" style="zoom:50%;" />

- 计算任务选择

  “计算任务” - 列出来对应 flow 中的计算任务列表，可以选择对应的任务来查看日志。

  通常一个 flow 中有一个实时任务和多个离线任务（如果没有则不显示）。

  计算任务名称以 flow 中计算节点的 **输出中文名** 来命名。

  <img src="../../assets/dataflow/tasklog/tasklog_task_select.png" alt="tasklog_task_select" style="zoom:50%;" />

- 其他选项

  - 任务阶段：运行/提交
  - 计算角色：对于离线任务 Executor ；对于实时任务 TaskManger / JobManager
  - 日志类型：Log / Stdout / Stderr / Exception
  - 运行容器：worker001，worker002 ...

- 日志内容列表

  - 时间：日志内容中的时间信息（不同任务的日志时间格式稍有不同）
  
  - 等级：INFO / WARN / ERROR 等级别，用户可点击等级旁边的按钮筛选某几种特定的日志级别
  
  - 来源：产生日志数据的类名等信息（不同任务的日志来源格式稍有不同）
  
  - 日志内容：具体的日志内容信息。如果单行日志内容较多，则会自动折叠，用户可以点击右侧按钮（或者双击日志内容）进行展开/折叠。
  
    
  
### 日志检索

  - 在“日志内容”后的输入框中输入想要查找的日志内容
    - 会实时在下方显示的日志内容列表中高亮包含对应内容的日志；
    - 点击右侧的“查询”按钮后，即可重新检索包含输入关键字的日志行；
  - 可以输入多个关键词，以空格分隔。多个关键词之间是 **或** 的关系；如输入“A B C”，则会检索出“包含 A 或者 B 或者 C ”的日志行；
  - 如果不输入关键词，则不检索，直接查看日志内容；
    <img src="../../assets/dataflow/tasklog/tasklog_search.png" alt="tasklog_search" style="zoom:50%;" />



