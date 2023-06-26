# devops\_ci\_dispatch

**数据库名：** devops\_ci\_dispatch

**文档版本：** 1.0.0

**文档描述：** devops\_ci\_dispatch的数据库文档

|                                表名                               |        说明       |
| :-------------------------------------------------------------: | :-------------: |
|             [T\_DISPATCH\_MACHINE](broken-reference)            |                 |
|         [T\_DISPATCH\_PIPELINE\_BUILD](broken-reference)        |                 |
|     [T\_DISPATCH\_PIPELINE\_DOCKER\_BUILD](broken-reference)    |                 |
|     [T\_DISPATCH\_PIPELINE\_DOCKER\_DEBUG](broken-reference)    |                 |
|    [T\_DISPATCH\_PIPELINE\_DOCKER\_ENABLE](broken-reference)    |                 |
|     [T\_DISPATCH\_PIPELINE\_DOCKER\_HOST](broken-reference)     |                 |
|  [T\_DISPATCH\_PIPELINE\_DOCKER\_HOST\_ZONE](broken-reference)  |                 |
|   [T\_DISPATCH\_PIPELINE\_DOCKER\_IP\_INFO](broken-reference)   |   DOCKER构建机负载表  |
|     [T\_DISPATCH\_PIPELINE\_DOCKER\_POOL](broken-reference)     |  DOCKER并发构建池状态表 |
|     [T\_DISPATCH\_PIPELINE\_DOCKER\_TASK](broken-reference)     |                 |
|  [T\_DISPATCH\_PIPELINE\_DOCKER\_TASK\_DRIFT](broken-reference) | DOCKER构建任务漂移记录表 |
| [T\_DISPATCH\_PIPELINE\_DOCKER\_TASK\_SIMPLE](broken-reference) |   DOCKER构建任务表   |
|   [T\_DISPATCH\_PIPELINE\_DOCKER\_TEMPLATE](broken-reference)   |                 |
|          [T\_DISPATCH\_PIPELINE\_VM](broken-reference)          |                 |
|           [T\_DISPATCH\_PRIVATE\_VM](broken-reference)          |                 |
|       [T\_DISPATCH\_PROJECT\_RUN\_TIME](broken-reference)       |    项目当月已使用额度    |
|        [T\_DISPATCH\_PROJECT\_SNAPSHOT](broken-reference)       |                 |
|         [T\_DISPATCH\_QUOTA\_PROJECT](broken-reference)         |       项目配额      |
|          [T\_DISPATCH\_QUOTA\_SYSTEM](broken-reference)         |       系统配额      |
|          [T\_DISPATCH\_RUNNING\_JOBS](broken-reference)         |     运行中的JOB     |
|    [T\_DISPATCH\_THIRDPARTY\_AGENT\_BUILD](broken-reference)    |                 |
|               [T\_DISPATCH\_VM](broken-reference)               |                 |
|            [T\_DISPATCH\_VM\_TYPE](broken-reference)            |                 |
|         [T\_DOCKER\_RESOURCE\_OPTIONS](broken-reference)        |   docker基础配额表   |

**表名：** T\_DISPATCH\_MACHINE

**说明：**

**数据列：**

|  序号 |           名称           |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |      说明      |
| :-: | :--------------------: | :------: | :-: | :-: | :--: | :-: | :-: | :----------: |
|  1  |       MACHINE\_ID      |    int   |  10 |  0  |   N  |  Y  |     |     机器ID     |
|  2  |       MACHINE\_IP      |  varchar | 128 |  0  |   N  |  N  |     |    机器ip地址    |
|  3  |      MACHINE\_NAME     |  varchar | 128 |  0  |   N  |  N  |     |     机器名称     |
|  4  |    MACHINE\_USERNAME   |  varchar | 128 |  0  |   N  |  N  |     |     机器用户名    |
|  5  |    MACHINE\_PASSWORD   |  varchar | 128 |  0  |   N  |  N  |     |     机器密码     |
|  6  | MACHINE\_CREATED\_TIME | datetime |  19 |  0  |   N  |  N  |     |    机器创建时间    |
|  7  | MACHINE\_UPDATED\_TIME | datetime |  19 |  0  |   N  |  N  |     |    机器修改时间    |
|  8  |    CURRENT\_VM\_RUN    |    int   |  10 |  0  |   N  |  N  |  0  |  当前运行的虚拟机台数  |
|  9  |      MAX\_VM\_RUN      |    int   |  10 |  0  |   N  |  N  |  1  | 最多允许允许的虚拟机台数 |

**表名：** T\_DISPATCH\_PIPELINE\_BUILD

**说明：**

**数据列：**

|  序号 |       名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明  |
| :-: | :-----------: | :------: | :-: | :-: | :--: | :-: | :-: | :---: |
|  1  |       ID      |  bigint  |  20 |  0  |   N  |  Y  |     |  主键ID |
|  2  |  PROJECT\_ID  |  varchar |  32 |  0  |   N  |  N  |     |  项目ID |
|  3  |  PIPELINE\_ID |  varchar |  34 |  0  |   N  |  N  |     | 流水线ID |
|  4  |   BUILD\_ID   |  varchar |  34 |  0  |   N  |  N  |     |  构建ID |
|  5  |  VM\_SEQ\_ID  |  varchar |  34 |  0  |   N  |  N  |     | 构建序列号 |
|  6  |     VM\_ID    |  bigint  |  20 |  0  |   N  |  N  |     | 虚拟机ID |
|  7  | CREATED\_TIME | datetime |  19 |  0  |   N  |  N  |     |  创建时间 |
|  8  | UPDATED\_TIME | datetime |  19 |  0  |   N  |  N  |     |  更新时间 |
|  9  |     STATUS    |    int   |  10 |  0  |   N  |  N  |     |   状态  |

**表名：** T\_DISPATCH\_PIPELINE\_DOCKER\_BUILD

**说明：**

**数据列：**

|  序号 |         名称        |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |     说明     |
| :-: | :---------------: | :------: | :---: | :-: | :--: | :-: | :-: | :--------: |
|  1  |         ID        |  bigint  |   20  |  0  |   N  |  Y  |     |    主键ID    |
|  2  |     BUILD\_ID     |  varchar |   64  |  0  |   N  |  N  |     |    构建ID    |
|  3  |    VM\_SEQ\_ID    |    int   |   10  |  0  |   N  |  N  |     |    构建序列号   |
|  4  |    SECRET\_KEY    |  varchar |   64  |  0  |   N  |  N  |     |     密钥     |
|  5  |       STATUS      |    int   |   10  |  0  |   N  |  N  |     |     状态     |
|  6  |   CREATED\_TIME   | datetime |   19  |  0  |   N  |  N  |     |    创建时间    |
|  7  |   UPDATED\_TIME   | datetime |   19  |  0  |   N  |  N  |     |    更新时间    |
|  8  |        ZONE       |  varchar |  128  |  0  |   Y  |  N  |     |    构建机地域   |
|  9  |    PROJECT\_ID    |  varchar |   34  |  0  |   Y  |  N  |     |    项目ID    |
|  10 |    PIPELINE\_ID   |  varchar |   34  |  0  |   Y  |  N  |     |    流水线ID   |
|  11 | DISPATCH\_MESSAGE |  varchar |  4096 |  0  |   Y  |  N  |     |    发送信息    |
|  12 |  STARTUP\_MESSAGE |   text   | 65535 |  0  |   Y  |  N  |     |    启动信息    |
|  13 |     ROUTE\_KEY    |  varchar |   64  |  0  |   Y  |  N  |     | 消息队列的路由KEY |
|  14 |  DOCKER\_INST\_ID |  bigint  |   20  |  0  |   Y  |  N  |     |            |
|  15 |    VERSION\_ID    |    int   |   10  |  0  |   Y  |  N  |     |    版本ID    |
|  16 |    TEMPLATE\_ID   |    int   |   10  |  0  |   Y  |  N  |     |    模板ID    |
|  17 |   NAMESPACE\_ID   |  bigint  |   20  |  0  |   Y  |  N  |     |   命名空间ID   |
|  18 |     DOCKER\_IP    |  varchar |   64  |  0  |   Y  |  N  |     |    构建机IP   |
|  19 |   CONTAINER\_ID   |  varchar |  128  |  0  |   Y  |  N  |     |   构建容器ID   |
|  20 |      POOL\_NO     |    int   |   10  |  0  |   Y  |  N  |  0  |   构建容器池序号  |

**表名：** T\_DISPATCH\_PIPELINE\_DOCKER\_DEBUG

**说明：**

**数据列：**

|  序号 |          名称         |   数据类型   |  长度  | 小数位 | 允许空值 |  主键 | 默认值 |       说明       |
| :-: | :-----------------: | :------: | :--: | :-: | :--: | :-: | :-: | :------------: |
|  1  |          ID         |  bigint  |  20  |  0  |   N  |  Y  |     |      主键ID      |
|  2  |     PROJECT\_ID     |  varchar |  64  |  0  |   N  |  N  |     |      项目ID      |
|  3  |     PIPELINE\_ID    |  varchar |  34  |  0  |   N  |  N  |     |      流水线ID     |
|  4  |     VM\_SEQ\_ID     |  varchar |  34  |  0  |   N  |  N  |     |      构建序列号     |
|  5  |       POOL\_NO      |    int   |  10  |  0  |   N  |  N  |  0  |      构建池序号     |
|  6  |        STATUS       |    int   |  10  |  0  |   N  |  N  |     |       状态       |
|  7  |        TOKEN        |  varchar |  128 |  0  |   Y  |  N  |     |      TOKEN     |
|  8  |     IMAGE\_NAME     |  varchar | 1024 |  0  |   N  |  N  |     |      镜像名称      |
|  9  |      HOST\_TAG      |  varchar |  128 |  0  |   Y  |  N  |     |      主机标签      |
|  10 |    CONTAINER\_ID    |  varchar |  128 |  0  |   Y  |  N  |     |     构建容器ID     |
|  11 |    CREATED\_TIME    | datetime |  19  |  0  |   N  |  N  |     |      创建时间      |
|  12 |    UPDATED\_TIME    | datetime |  19  |  0  |   N  |  N  |     |      修改时间      |
|  13 |         ZONE        |  varchar |  128 |  0  |   Y  |  N  |     |      构建机地域     |
|  14 |      BUILD\_ENV     |  varchar | 4096 |  0  |   Y  |  N  |     |     构建机环境变量    |
|  15 |    REGISTRY\_USER   |  varchar |  128 |  0  |   Y  |  N  |     |      注册用户名     |
|  16 |    REGISTRY\_PWD    |  varchar |  128 |  0  |   Y  |  N  |     |     注册用户密码     |
|  17 |     IMAGE\_TYPE     |  varchar |  128 |  0  |   Y  |  N  |     |      镜像类型      |
|  18 | IMAGE\_PUBLIC\_FLAG |    bit   |   1  |  0  |   Y  |  N  |     | 镜像是否为公共镜像：0否1是 |
|  19 |   IMAGE\_RD\_TYPE   |    bit   |   1  |  0  |   Y  |  N  |     | 镜像研发来源：0自研1第三方 |

**表名：** T\_DISPATCH\_PIPELINE\_DOCKER\_ENABLE

**说明：**

**数据列：**

|  序号 |      名称      |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明  |
| :-: | :----------: | :-----: | :-: | :-: | :--: | :-: | :-: | :---: |
|  1  | PIPELINE\_ID | varchar |  64 |  0  |   N  |  Y  |     | 流水线ID |
|  2  |    ENABLE    |   bit   |  1  |  0  |   N  |  N  |  0  |  是否启用 |
|  3  |  VM\_SEQ\_ID |   int   |  10 |  0  |   N  |  Y  |  -1 | 构建序列号 |

**表名：** T\_DISPATCH\_PIPELINE\_DOCKER\_HOST

**说明：**

**数据列：**

|  序号 |       名称      |   数据类型   |  长度  | 小数位 | 允许空值 |  主键 | 默认值 |     说明     |
| :-: | :-----------: | :------: | :--: | :-: | :--: | :-: | :-: | :--------: |
|  1  | PROJECT\_CODE |  varchar |  128 |  0  |   N  |  Y  |     |   用户组所属项目  |
|  2  |    HOST\_IP   |  varchar |  128 |  0  |   N  |  Y  |     |    主机ip    |
|  3  |     REMARK    |  varchar | 1024 |  0  |   Y  |  N  |     |     评论     |
|  4  | CREATED\_TIME | datetime |  19  |  0  |   N  |  N  |     |    创建时间    |
|  5  | UPDATED\_TIME | datetime |  19  |  0  |   N  |  N  |     |    更新时间    |
|  6  |      TYPE     |    int   |  10  |  0  |   N  |  N  |  0  |     类型     |
|  7  |   ROUTE\_KEY  |  varchar |  45  |  0  |   Y  |  N  |     | 消息队列的路由KEY |

**表名：** T\_DISPATCH\_PIPELINE\_DOCKER\_HOST\_ZONE

**说明：**

**数据列：**

|  序号 |       名称      |   数据类型   |  长度  | 小数位 | 允许空值 |  主键 | 默认值 |     说明     |
| :-: | :-----------: | :------: | :--: | :-: | :--: | :-: | :-: | :--------: |
|  1  |    HOST\_IP   |  varchar |  128 |  0  |   N  |  Y  |     |    主机ip    |
|  2  |      ZONE     |  varchar |  128 |  0  |   N  |  N  |     |    构建机地域   |
|  3  |     ENABLE    |    bit   |   1  |  0  |   Y  |  N  |  1  |    是否启用    |
|  4  |     REMARK    |  varchar | 1024 |  0  |   Y  |  N  |     |     评论     |
|  5  | CREATED\_TIME | datetime |  19  |  0  |   N  |  N  |     |    创建时间    |
|  6  | UPDATED\_TIME | datetime |  19  |  0  |   N  |  N  |     |    更新时间    |
|  7  |      TYPE     |    int   |  10  |  0  |   N  |  N  |  0  |     类型     |
|  8  |   ROUTE\_KEY  |  varchar |  45  |  0  |   Y  |  N  |     | 消息队列的路由KEY |

**表名：** T\_DISPATCH\_PIPELINE\_DOCKER\_IP\_INFO

**说明：** DOCKER构建机负载表

**数据列：**

|  序号 |         名称         |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |      说明      |
| :-: | :----------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :----------: |
|  1  |         ID         |  bigint  |  20 |  0  |   N  |  Y  |                    |      主键      |
|  2  |     DOCKER\_IP     |  varchar |  64 |  0  |   N  |  N  |                    |   DOCKERIP   |
|  3  | DOCKER\_HOST\_PORT |    int   |  10 |  0  |   N  |  N  |         80         |  DOCKERPORT  |
|  4  |      CAPACITY      |    int   |  10 |  0  |   N  |  N  |          0         |    节点容器总容量   |
|  5  |      USED\_NUM     |    int   |  10 |  0  |   N  |  N  |          0         |   节点容器已使用容量  |
|  6  |      CPU\_LOAD     |    int   |  10 |  0  |   N  |  N  |          0         |   节点容器CPU负载  |
|  7  |      MEM\_LOAD     |    int   |  10 |  0  |   N  |  N  |          0         |   节点容器MEM负载  |
|  8  |     DISK\_LOAD     |    int   |  10 |  0  |   N  |  N  |          0         |  节点容器DISK负载  |
|  9  |   DISK\_IO\_LOAD   |    int   |  10 |  0  |   N  |  N  |          0         | 节点容器DISKIO负载 |
|  10 |       ENABLE       |    bit   |  1  |  0  |   Y  |  N  |        b'0'        |    节点是否可用    |
|  11 |     SPECIAL\_ON    |    bit   |  1  |  0  |   Y  |  N  |        b'0'        |   节点是否作为专用机  |
|  12 |      GRAY\_ENV     |    bit   |  1  |  0  |   Y  |  N  |        b'0'        |    是否为灰度节点   |
|  13 |    CLUSTER\_NAME   |  varchar |  64 |  0  |   Y  |  N  |       COMMON       |    构建集群类型    |
|  14 |     GMT\_CREATE    | datetime |  19 |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |     创建时间     |
|  15 |    GMT\_MODIFIED   | datetime |  19 |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |     修改时间     |

**表名：** T\_DISPATCH\_PIPELINE\_DOCKER\_POOL

**说明：** DOCKER并发构建池状态表

**数据列：**

|  序号 |       名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |   说明  |
| :-: | :-----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :---: |
|  1  |       ID      |  bigint  |  20 |  0  |   N  |  Y  |                    |   主键  |
|  2  |  PIPELINE\_ID |  varchar |  64 |  0  |   N  |  N  |                    | 流水线ID |
|  3  |    VM\_SEQ    |  varchar |  64 |  0  |   N  |  N  |                    | 构建机序号 |
|  4  |    POOL\_NO   |    int   |  10 |  0  |   N  |  N  |          0         | 构建池序号 |
|  5  |     STATUS    |    int   |  10 |  0  |   N  |  N  |          0         | 构建池状态 |
|  6  |  GMT\_CREATE  | datetime |  19 |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |  创建时间 |
|  7  | GMT\_MODIFIED | datetime |  19 |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |  修改时间 |

**表名：** T\_DISPATCH\_PIPELINE\_DOCKER\_TASK

**说明：**

**数据列：**

|  序号 |          名称         |   数据类型   |  长度  | 小数位 | 允许空值 |  主键 | 默认值 |       说明       |
| :-: | :-----------------: | :------: | :--: | :-: | :--: | :-: | :-: | :------------: |
|  1  |          ID         |  bigint  |  20  |  0  |   N  |  Y  |     |      主键ID      |
|  2  |     PROJECT\_ID     |  varchar |  64  |  0  |   N  |  N  |     |      项目ID      |
|  3  |      AGENT\_ID      |  varchar |  32  |  0  |   N  |  N  |     |      构建机ID     |
|  4  |     PIPELINE\_ID    |  varchar |  34  |  0  |   N  |  N  |     |      流水线ID     |
|  5  |      BUILD\_ID      |  varchar |  34  |  0  |   N  |  N  |     |      构建ID      |
|  6  |     VM\_SEQ\_ID     |    int   |  10  |  0  |   N  |  N  |     |      构建序列号     |
|  7  |        STATUS       |    int   |  10  |  0  |   N  |  N  |     |       状态       |
|  8  |     SECRET\_KEY     |  varchar |  128 |  0  |   N  |  N  |     |       密钥       |
|  9  |     IMAGE\_NAME     |  varchar | 1024 |  0  |   N  |  N  |     |      镜像名称      |
|  10 |    CHANNEL\_CODE    |  varchar |  128 |  0  |   Y  |  N  |     |    渠道号，默认为DS   |
|  11 |      HOST\_TAG      |  varchar |  128 |  0  |   Y  |  N  |     |      主机标签      |
|  12 |    CONTAINER\_ID    |  varchar |  128 |  0  |   Y  |  N  |     |     构建容器ID     |
|  13 |    CREATED\_TIME    | datetime |  19  |  0  |   N  |  N  |     |      创建时间      |
|  14 |    UPDATED\_TIME    | datetime |  19  |  0  |   N  |  N  |     |      更新时间      |
|  15 |         ZONE        |  varchar |  128 |  0  |   Y  |  N  |     |      构建机地域     |
|  16 |    REGISTRY\_USER   |  varchar |  128 |  0  |   Y  |  N  |     |      注册用户名     |
|  17 |    REGISTRY\_PWD    |  varchar |  128 |  0  |   Y  |  N  |     |     注册用户密码     |
|  18 |     IMAGE\_TYPE     |  varchar |  128 |  0  |   Y  |  N  |     |      镜像类型      |
|  19 | CONTAINER\_HASH\_ID |  varchar |  128 |  0  |   Y  |  N  |     |    构建Job唯一标识   |
|  20 | IMAGE\_PUBLIC\_FLAG |    bit   |   1  |  0  |   Y  |  N  |     | 镜像是否为公共镜像：0否1是 |
|  21 |   IMAGE\_RD\_TYPE   |    bit   |   1  |  0  |   Y  |  N  |     | 镜像研发来源：0自研1第三方 |

**表名：** T\_DISPATCH\_PIPELINE\_DOCKER\_TASK\_DRIFT

**说明：** DOCKER构建任务漂移记录表

**数据列：**

|  序号 |           名称          |   数据类型   |  长度  | 小数位 | 允许空值 |  主键 |         默认值        |    说明   |
| :-: | :-------------------: | :------: | :--: | :-: | :--: | :-: | :----------------: | :-----: |
|  1  |           ID          |  bigint  |  20  |  0  |   N  |  Y  |                    |    主键   |
|  2  |      PIPELINE\_ID     |  varchar |  64  |  0  |   N  |  N  |                    |  流水线ID  |
|  3  |       BUILD\_ID       |  varchar |  64  |  0  |   N  |  N  |                    |   构建ID  |
|  4  |        VM\_SEQ        |  varchar |  64  |  0  |   N  |  N  |                    |  构建机序号  |
|  5  |    OLD\_DOCKER\_IP    |  varchar |  64  |  0  |   N  |  N  |                    | 旧构建容器IP |
|  6  |    NEW\_DOCKER\_IP    |  varchar |  64  |  0  |   N  |  N  |                    | 新构建容器IP |
|  7  | OLD\_DOCKER\_IP\_INFO |  varchar | 1024 |  0  |   N  |  N  |                    | 旧容器IP负载 |
|  8  |      GMT\_CREATE      | datetime |  19  |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |   创建时间  |
|  9  |     GMT\_MODIFIED     | datetime |  19  |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |   修改时间  |

**表名：** T\_DISPATCH\_PIPELINE\_DOCKER\_TASK\_SIMPLE

**说明：** DOCKER构建任务表

**数据列：**

|  序号 |            名称            |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |   说明   |
| :-: | :----------------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :----: |
|  1  |            ID            |  bigint  |  20 |  0  |   N  |  Y  |                    |   主键   |
|  2  |       PIPELINE\_ID       |  varchar |  64 |  0  |   N  |  N  |                    |  流水线ID |
|  3  |          VM\_SEQ         |  varchar |  64 |  0  |   N  |  N  |                    |  构建机序号 |
|  4  |        DOCKER\_IP        |  varchar |  64 |  0  |   N  |  N  |                    | 构建容器IP |
|  5  | DOCKER\_RESOURCE\_OPTION |    int   |  10 |  0  |   N  |  N  |          0         | 构建资源配置 |
|  6  |        GMT\_CREATE       | datetime |  19 |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |  创建时间  |
|  7  |       GMT\_MODIFIED      | datetime |  19 |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |  修改时间  |

**表名：** T\_DISPATCH\_PIPELINE\_DOCKER\_TEMPLATE

**说明：**

**数据列：**

|  序号 |          名称         |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :-----------------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |          ID         |    int   |  10 |  0  |   N  |  Y  |     | 主键ID |
|  2  |     VERSION\_ID     |    int   |  10 |  0  |   N  |  N  |     | 版本ID |
|  3  |  SHOW\_VERSION\_ID  |    int   |  10 |  0  |   N  |  N  |     |      |
|  4  | SHOW\_VERSION\_NAME |  varchar |  64 |  0  |   N  |  N  |     | 版本名称 |
|  5  |    DEPLOYMENT\_ID   |    int   |  10 |  0  |   N  |  N  |     | 部署ID |
|  6  |   DEPLOYMENT\_NAME  |  varchar |  64 |  0  |   N  |  N  |     | 部署名称 |
|  7  |     CC\_APP\_ID     |  bigint  |  20 |  0  |   N  |  N  |     | 应用ID |
|  8  |   BCS\_PROJECT\_ID  |  varchar |  64 |  0  |   N  |  N  |     |      |
|  9  |     CLUSTER\_ID     |  varchar |  64 |  0  |   N  |  N  |     | 集群ID |
|  10 |    CREATED\_TIME    | datetime |  19 |  0  |   N  |  N  |     | 创建时间 |

**表名：** T\_DISPATCH\_PIPELINE\_VM

**说明：**

**数据列：**

|  序号 |      名称      |   数据类型  |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |   说明  |
| :-: | :----------: | :-----: | :---: | :-: | :--: | :-: | :-: | :---: |
|  1  | PIPELINE\_ID | varchar |   64  |  0  |   N  |  Y  |     | 流水线ID |
|  2  |   VM\_NAMES  |   text  | 65535 |  0  |   N  |  N  |     |  VM名称 |
|  3  |  VM\_SEQ\_ID |   int   |   10  |  0  |   N  |  Y  |  -1 | 构建序列号 |

**表名：** T\_DISPATCH\_PRIVATE\_VM

**说明：**

**数据列：**

|  序号 |      名称     |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :---------: | :-----: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |    VM\_ID   |   int   |  10 |  0  |   N  |  Y  |     | VMID |
|  2  | PROJECT\_ID | varchar |  64 |  0  |   N  |  N  |     | 项目ID |

**表名：** T\_DISPATCH\_PROJECT\_RUN\_TIME

**说明：** 项目当月已使用额度

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |  PROJECT\_ID |  varchar | 128 |  0  |   N  |  Y  |     | 项目ID |
|  2  |   VM\_TYPE   |  varchar | 128 |  0  |   N  |  Y  |     | VM类型 |
|  3  |   RUN\_TIME  |  bigint  |  20 |  0  |   N  |  N  |     | 运行时长 |
|  4  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  |     | 更新时间 |

**表名：** T\_DISPATCH\_PROJECT\_SNAPSHOT

**说明：**

**数据列：**

|  序号 |           名称          |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明   |
| :-: | :-------------------: | :-----: | :-: | :-: | :--: | :-: | :-: | :----: |
|  1  |      PROJECT\_ID      | varchar |  64 |  0  |   N  |  Y  |     |  项目ID  |
|  2  | VM\_STARTUP\_SNAPSHOT | varchar |  64 |  0  |   N  |  N  |     | VM启动快照 |

**表名：** T\_DISPATCH\_QUOTA\_PROJECT

**说明：** 项目配额

**数据列：**

|  序号 |              名称             |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |       说明      |
| :-: | :-------------------------: | :------: | :-: | :-: | :--: | :-: | :-: | :-----------: |
|  1  |         PROJECT\_ID         |  varchar | 128 |  0  |   N  |  Y  |     |      项目ID     |
|  2  |           VM\_TYPE          |  varchar | 128 |  0  |   N  |  Y  |     |      VM类型     |
|  3  |      RUNNING\_JOBS\_MAX     |    int   |  10 |  0  |   N  |  N  |     |   项目最大并发JOB数  |
|  4  |   RUNNING\_TIME\_JOB\_MAX   |    int   |  10 |  0  |   N  |  N  |     |  项目单JOB最大执行时间 |
|  5  | RUNNING\_TIME\_PROJECT\_MAX |    int   |  10 |  0  |   N  |  N  |     | 项目所有JOB最大执行时间 |
|  6  |        CREATED\_TIME        | datetime |  19 |  0  |   N  |  N  |     |      创建时间     |
|  7  |        UPDATED\_TIME        | datetime |  19 |  0  |   N  |  N  |     |      更新时间     |
|  8  |           OPERATOR          |  varchar | 128 |  0  |   N  |  N  |     |      操作人      |

**表名：** T\_DISPATCH\_QUOTA\_SYSTEM

**说明：** 系统配额

**数据列：**

|  序号 |                    名称                   |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |         说明        |
| :-: | :-------------------------------------: | :------: | :-: | :-: | :--: | :-: | :-: | :---------------: |
|  1  |                 VM\_TYPE                |  varchar | 128 |  0  |   N  |  Y  |     |       构建机类型       |
|  2  |        RUNNING\_JOBS\_MAX\_SYSTEM       |    int   |  10 |  0  |   N  |  N  |     |    BKCI系统最大并发JOB数   |
|  3  |       RUNNING\_JOBS\_MAX\_PROJECT       |    int   |  10 |  0  |   N  |  N  |     |   单项目默认最大并发JOB数   |
|  4  |         RUNNING\_TIME\_JOB\_MAX         |    int   |  10 |  0  |   N  |  N  |     | 系统默认所有单个JOB最大执行时间 |
|  5  |     RUNNING\_TIME\_JOB\_MAX\_PROJECT    |    int   |  10 |  0  |   N  |  N  |     |  默认单项目所有JOB最大执行时间 |
|  6  |    RUNNING\_JOBS\_MAX\_GITCI\_SYSTEM    |    int   |  10 |  0  |   N  |  N  |     |  工蜂CI系统总最大并发JOB数量 |
|  7  |    RUNNING\_JOBS\_MAX\_GITCI\_PROJECT   |    int   |  10 |  0  |   N  |  N  |     |  工蜂CI单项目最大并发JOB数量 |
|  8  |      RUNNING\_TIME\_JOB\_MAX\_GITCI     |    int   |  10 |  0  |   N  |  N  |     |   工蜂CI单JOB最大执行时间  |
|  9  | RUNNING\_TIME\_JOB\_MAX\_PROJECT\_GITCI |    int   |  10 |  0  |   N  |  N  |     |   工蜂CI单项目最大执行时间   |
|  10 |     PROJECT\_RUNNING\_JOB\_THRESHOLD    |    int   |  10 |  0  |   N  |  N  |     |   项目执行job数量告警阈值   |
|  11 |    PROJECT\_RUNNING\_TIME\_THRESHOLD    |    int   |  10 |  0  |   N  |  N  |     |   项目执行job时间告警阈值   |
|  12 |     SYSTEM\_RUNNING\_JOB\_THRESHOLD     |    int   |  10 |  0  |   N  |  N  |     |   系统执行job数量告警阈值   |
|  13 |              CREATED\_TIME              | datetime |  19 |  0  |   N  |  N  |     |        创建时间       |
|  14 |              UPDATED\_TIME              | datetime |  19 |  0  |   N  |  N  |     |        更新时间       |
|  15 |                 OPERATOR                |  varchar | 128 |  0  |   N  |  N  |     |        操作人        |

**表名：** T\_DISPATCH\_RUNNING\_JOBS

**说明：** 运行中的JOB

**数据列：**

|  序号 |         名称         |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |    说明   |
| :-: | :----------------: | :------: | :-: | :-: | :--: | :-: | :-: | :-----: |
|  1  |         ID         |    int   |  10 |  0  |   N  |  Y  |     |   主键ID  |
|  2  |     PROJECT\_ID    |  varchar | 128 |  0  |   N  |  N  |     |   项目ID  |
|  3  |      VM\_TYPE      |  varchar | 128 |  0  |   N  |  N  |     |   VM类型  |
|  4  |      BUILD\_ID     |  varchar | 128 |  0  |   N  |  N  |     |   构建ID  |
|  5  |     VM\_SEQ\_ID    |  varchar | 128 |  0  |   N  |  N  |     |  构建序列号  |
|  6  |   EXECUTE\_COUNT   |    int   |  10 |  0  |   N  |  N  |     |   执行次数  |
|  7  |    CREATED\_TIME   | datetime |  19 |  0  |   N  |  N  |     |   创建时间  |
|  8  | AGENT\_START\_TIME | datetime |  19 |  0  |   Y  |  N  |     | 构建机启动时间 |

**表名：** T\_DISPATCH\_THIRDPARTY\_AGENT\_BUILD

**说明：**

**数据列：**

|  序号 |       名称       |   数据类型   |  长度  | 小数位 | 允许空值 |  主键 | 默认值 |   说明  |
| :-: | :------------: | :------: | :--: | :-: | :--: | :-: | :-: | :---: |
|  1  |       ID       |  bigint  |  20  |  0  |   N  |  Y  |     |  主键ID |
|  2  |   PROJECT\_ID  |  varchar |  64  |  0  |   N  |  N  |     |  项目ID |
|  3  |    AGENT\_ID   |  varchar |  32  |  0  |   N  |  N  |     | 构建机ID |
|  4  |  PIPELINE\_ID  |  varchar |  34  |  0  |   N  |  N  |     | 流水线ID |
|  5  |    BUILD\_ID   |  varchar |  34  |  0  |   N  |  N  |     |  构建ID |
|  6  |   VM\_SEQ\_ID  |  varchar |  34  |  0  |   N  |  N  |     | 构建序列号 |
|  7  |     STATUS     |    int   |  10  |  0  |   N  |  N  |     |   状态  |
|  8  |  CREATED\_TIME | datetime |  19  |  0  |   N  |  N  |     |  创建时间 |
|  9  |  UPDATED\_TIME | datetime |  19  |  0  |   N  |  N  |     |  更新时间 |
|  10 |    WORKSPACE   |  varchar | 4096 |  0  |   Y  |  N  |     |  工作空间 |
|  11 |   BUILD\_NUM   |    int   |  10  |  0  |   Y  |  N  |  0  |  构建次数 |
|  12 | PIPELINE\_NAME |  varchar |  255 |  0  |   Y  |  N  |     | 流水线名称 |
|  13 |   TASK\_NAME   |  varchar |  255 |  0  |   Y  |  N  |     |  任务名称 |

**表名：** T\_DISPATCH\_VM

**说明：**

**数据列：**

|  序号 |           名称          |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |     说明    |
| :-: | :-------------------: | :------: | :-: | :-: | :--: | :-: | :-: | :-------: |
|  1  |         VM\_ID        |  bigint  |  20 |  0  |   N  |  Y  |     |    主键ID   |
|  2  |    VM\_MACHINE\_ID    |    int   |  10 |  0  |   N  |  N  |     |  VM对应母机ID |
|  3  |         VM\_IP        |  varchar | 128 |  0  |   N  |  N  |     |   VMIP地址  |
|  4  |        VM\_NAME       |  varchar | 128 |  0  |   N  |  N  |     |    VM名称   |
|  5  |         VM\_OS        |  varchar |  64 |  0  |   N  |  N  |     |   VM系统信息  |
|  6  |    VM\_OS\_VERSION    |  varchar |  64 |  0  |   N  |  N  |     |  VM系统信息版本 |
|  7  |        VM\_CPU        |  varchar |  64 |  0  |   N  |  N  |     |  VMCPU信息  |
|  8  |       VM\_MEMORY      |  varchar |  64 |  0  |   N  |  N  |     |   VM内存信息  |
|  9  |      VM\_TYPE\_ID     |    int   |  10 |  0  |   N  |  N  |     |   VM类型ID  |
|  10 |      VM\_MAINTAIN     |    bit   |  1  |  0  |   N  |  N  |  0  | VM是否在维护状态 |
|  11 | VM\_MANAGER\_USERNAME |  varchar | 128 |  0  |   N  |  N  |     |  VM管理员用户名 |
|  12 |  VM\_MANAGER\_PASSWD  |  varchar | 128 |  0  |   N  |  N  |     |  VM管理员密码  |
|  13 |      VM\_USERNAME     |  varchar | 128 |  0  |   N  |  N  |     | VM非管理员用户名 |
|  14 |       VM\_PASSWD      |  varchar | 128 |  0  |   N  |  N  |     |  VM非管理员密码 |
|  15 |   VM\_CREATED\_TIME   | datetime |  19 |  0  |   N  |  N  |     |    创建时间   |
|  16 |   VM\_UPDATED\_TIME   | datetime |  19 |  0  |   N  |  N  |     |    修改时间   |

**表名：** T\_DISPATCH\_VM\_TYPE

**说明：**

**数据列：**

|  序号 |          名称         |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :-----------------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |       TYPE\_ID      |    int   |  10 |  0  |   N  |  Y  |     | 主键ID |
|  2  |      TYPE\_NAME     |  varchar |  64 |  0  |   N  |  N  |     |  名称  |
|  3  | TYPE\_CREATED\_TIME | datetime |  19 |  0  |   N  |  N  |     | 创建时间 |
|  4  | TYPE\_UPDATED\_TIME | datetime |  19 |  0  |   N  |  N  |     | 更新时间 |

**表名：** T\_DOCKER\_RESOURCE\_OPTIONS

**说明：** docker基础配额表

**数据列：**

|  序号 |             名称            |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |       说明      |
| :-: | :-----------------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-----------: |
|  1  |             ID            |  bigint  |  20 |  0  |   N  |  Y  |                    |       主键      |
|  2  |        CPU\_PERIOD        |    int   |  10 |  0  |   N  |  N  |        10000       |     CPU配置     |
|  3  |         CPU\_QUOTA        |    int   |  10 |  0  |   N  |  N  |       160000       |     CPU配置     |
|  4  |    MEMORY\_LIMIT\_BYTES   |  bigint  |  20 |  0  |   N  |  N  |     34359738368    |     内存：32G    |
|  5  |            DISK           |    int   |  10 |  0  |   N  |  N  |         100        |    磁盘：100G    |
|  6  | BLKIO\_DEVICE\_WRITE\_BPS |  bigint  |  20 |  0  |   N  |  N  |      125829120     | 磁盘写入速率，120m/s |
|  7  |  BLKIO\_DEVICE\_READ\_BPS |  bigint  |  20 |  0  |   N  |  N  |      125829120     | 磁盘读入速率，120m/s |
|  8  |        DESCRIPTION        |  varchar | 128 |  0  |   N  |  N  |                    |       描述      |
|  9  |        GMT\_CREATE        | datetime |  19 |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |      创建时间     |
|  10 |       GMT\_MODIFIED       | datetime |  19 |  0  |   Y  |  N  | CURRENT\_TIMESTAMP |      修改时间     |
