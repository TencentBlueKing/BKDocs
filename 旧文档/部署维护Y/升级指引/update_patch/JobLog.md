# 作业平台社区版日志迁移工具使用说明 {#JobLog}

### 功能

- 由于社区版5.0.0之前的作业执行日志是以文件的形式存放在磁盘上，而5.0.0版本之后的作业执行日志存放在Mysql中。本工具把日志文件导出成为SQL文件，通过执行sql脚本迁移执行日志数据到db中。

### 使用说明

- 提供迁移工具ce_job_migrate-bin.tgz，解压后目录如下：

  ![JobLog0](../../assets/JobLog0.png)

- 说明：

  ![JobLog1](../../assets/JobLog1.png)

- 具体的数据迁移步骤为：
  - 执行前检查
  - 导出日志文件为sql脚本
  - 升级job到新版本，启动之后验证功能正常
  - 执行工具导出的sql脚本，导入原始数据到db
  - 数据迁移验证

### 执行前检查

- 迁移数据之前需要保证：
  - 社区版job服务停止（避免产生新的数据和影响读取效率）

- 导出操作说明：

  - 上传ce_job_migrate-bin.tgz到社区版job服务器上，并解压缩
  - 进入job-utils目录，使用root用户执行
  - ![JobLog2](../../assets/JobLog2.png)
  - ![JobLog3](../../assets/JobLog3.png)
  - 脚本会提示输入导出数据的时间范围（作业执行的日志这个日期跟作业平台数据库迁移步骤中选择的时间范围保持一致），建议保留最近的执行日志，而不是全量导出。如果需要全量导出，直接回车即可；全量导出可能会导致导出导入比较耗时。

- 导出数据按照日志产生的日期存放在job/utils/export_data/log目录下面

  - ![JobLog4](../../assets/JobLog4.png)

- 说明：

 - ![JobLog5](../../assets/JobLog5.png)

- 导入操作说明

  - 同步导出的sql文件到社区版中控机上（比如路径为/tmp/job/export_data/log/
  - cd到/tmp/job/export_data/log/目录下(确保MYSQL命令行能够执行到当前路径下的sql文件)。然后登陆MYSQL:
  - ![JobLog6](../../assets/JobLog6.png)

- 使用MYSQL命令行，切换到名称为jobLog的schema下:

  - ![JobLog7](../../assets/JobLog7.png)

- 初始化job的db（jobLog，用于存储作业执行日志）。通过MYSQL命令行执行
    ```bash
    source clean_jobLog_db.sql
    ```
- 导入数据，通过MYSQL命令行执行
    ```bash
    source batch_import.sql
    ```
  >注意，必须保证执行过程中没有任何错误；如果出现错误，那么本次数据导入失败，需要分析原因再次清理数据后进行导入。

- 验证:
  - 启动作业平台服务器
  - 检查历史执行作业，查看日志是否完整迁移
  - 验证其他功能
