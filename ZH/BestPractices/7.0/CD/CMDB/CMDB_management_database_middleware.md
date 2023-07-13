# CMDB 案例-DB 实例的管理

## 情景

应用使用的存储是 MySQL，为了便于 MySQL 的日常维护（如 SQL 变更），需要在 CMDB 中创建 MySQL CI 对象，录入 MySQL 实例。

> 蓝鲸 CMDB 拥有灵活的 CI 能力，掌握该教程后，可以管理数据库、中间件、硬件等 CI 对象

## 前提条件

在配置平台中 [新建业务](../../../../CMDB/3.10/UserGuide/QuickStart/case1.md)，并 定义拓扑及分配主机。

**术语解释**
- **CI** : (Configuration Items)，资源对象，如 `MySQL`、主机、交易系统、交换机、路由器等
- **CI 属性** : (Configuration Items Attribute)，资源对象的配置属性，如 MySQL CI 属性为实例名、IP、端口、存储引擎、数据库版本等
- **CI 实例** : CI 的实例化，唯一识别一个资源对象，如 MySQL CI 实例为`gd_area_master_01`

## 操作步骤

- 梳理 : 梳理 MySQL CI 属性
- 建模 : 创建 MySQL CI 对象
- 实例化 : 添加 MySQL 实例

### 梳理 MySQL CI 属性

根据消费 MySQL 的场景，梳理 MySQL 常见的 CI 属性。

<table>
   <tr>
      <td>字段分组</td>
      <td>唯一标识</td>
      <td>名称</td>
      <td>字段类型</td>
      <td>录入方式</td>
      <td>是否唯一</td>
      <td>是否必填</td>
   </tr>
   <tr>
      <td rowspan=11>Default</td>
      <td>bk_inst_name</td>
      <td>实例名</td>
      <td>短字符</td>
      <td>自动</td>
      <td>是</td>
      <td>是</td>
   </tr>
   <tr>
      <td>ip_addr</td>
      <td>IP地址</td>
      <td>短字符</td>
      <td>自动</td>
      <td>是</td>
      <td>是</td>
   </tr>
   <tr>
      <td>port</td>
      <td>端口</td>
      <td>数字</td>
      <td>自动</td>
      <td>是</td>
      <td>是</td>
   </tr>
   <tr>
      <td>version</td>
      <td>数据库版本</td>
      <td>短字符</td>
      <td>自动</td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td>install_dir</td>
      <td>安装路径</td>
      <td>长字符</td>
      <td>自动</td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td>dbfile_dir</td>
      <td>数据库文件路径</td>
      <td>长字符</td>
      <td>自动</td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td>enable_binlog</td>
      <td>是否开启binlog</td>
      <td>枚举</td>
      <td>自动</td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td>enable_slowlog</td>
      <td>是否开启慢查询日志</td>
      <td>枚举</td>
      <td>自动</td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td>chart_set</td>
      <td>字符集</td>
      <td>短字符</td>
      <td>自动</td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td>storage_engine</td>
      <td>存储引擎</td>
      <td>短字符</td>
      <td>自动</td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td>db_size</td>
      <td>数据库大小</td>
      <td>数字</td>
      <td>自动</td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td rowspan=6>核心参数</td>
      <td>innodb_buffer_pool_size</td>
      <td>innodb缓存池大小</td>
      <td>数字</td>
      <td>自动</td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td>innodb_log_buffer_size</td>
      <td>innodb日志缓存大小</td>
      <td>数字</td>
      <td>自动</td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td>innodb_flush_log_at_trx_commit</td>
      <td>innodb日志磁盘写入策略</td>
      <td>短字符</td>
      <td>自动</td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td>thread_cache_size</td>
      <td>线程缓存大小</td>
      <td>数字</td>
      <td>自动</td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td>query_cache_size</td>
      <td>查询缓存大小</td>
      <td>数字</td>
      <td>自动</td>
      <td></td>
      <td></td>
   </tr>
   <tr>
      <td>max_connections</td>
      <td>最大连接数</td>
      <td>数字</td>
      <td>自动</td>
      <td></td>
      <td></td>
   </tr>
</table>

通过`实例名`可以唯一标识一个 MySQL 实例，具体是`IP`和`端口`的组合。

### 创建 MySQL CI 对象

第一步梳理完 MySQL CI 属性后，接下来开始建模：创建 MySQL CI。

#### 创建 CI

选择`模型管理`中选择`模型`，创建 MySQL 模型。

![-w992](../assets/20210408114711.png)

#### 新增 CI 属性

按照梳理 MySQL CI 属性 中梳理的结果来添加 CI 属性。

![-w1676](../assets/20210408125755.png)

如果手工操作繁琐，也可以导入一个 MySQL 模型示例。

#### 新增唯一校验

通过`实例名`可以唯一标识一个 MySQL 实例，具体是`IP`和`端口`的组合，所以将 IP 和端口作为一个组合校验。

![-w1676](../assets/20210408125841.png)

#### 设立 CI 关联

针对 MySQL 的管理，除了 CI 属性外，我们同时还关心 MySQL 运行在哪台主机上，所以需要在模型中新建一个“主机上运行 MySQL”的关联。

1 个主机可以运行多个 MySQL 实例，所以`源到目标的约束条件`为“ 1-N ”

![-w1239](../assets/16178641731970.png)

### 添加 MySQL 实例

完成 MySQL CI 的建模之后，接下来添加 MySQL 实例

#### 新增或导入 CI 实例

从 **资源 -> 资源目录**进入 MySQL 实例列表页

点击**新建**按钮，按提示添加 MySQL 实例，也可以批量导入 MySQL 实例。

![-w1399](../assets/20210408145717.png)

#### 创建 CI 实例的关联关系

打开一个 MySQL 实例的详情页，点击`关联` TAB 中的`关联管理`，`关联`当前实例运行在哪台主机上。

![-w1398](../assets/20210408145828.png)

再次点击`关联管理`，可预览 MySQL 实例与主机的关联关系。

![-w1320](../assets/20210408150024.png)

如果参照本篇教程将`机架`、`交换机`、`机房管理单元`、`数据中心`等 IT 基础设施均录入 CMDB 中，将可以查询一个 MySQL 实例完整的关联关系。

![-w1397](../assets/20210408150251.png)
