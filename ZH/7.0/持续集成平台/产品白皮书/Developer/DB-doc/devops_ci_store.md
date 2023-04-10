# devops\_ci\_store

**数据库名：** devops\_ci\_store

**文档版本：** 1.0.0

**文档描述：** devops\_ci\_store的数据库文档

|                          表名                          |                      说明                     |
| :--------------------------------------------------: | :-----------------------------------------: |
|              [T\_APPS](broken-reference)             |                   编译环境信息表                   |
|            [T\_APP\_ENV](broken-reference)           |                   编译环境变量表                   |
|          [T\_APP\_VERSION](broken-reference)         |                  编译环境版本信息表                  |
|              [T\_ATOM](broken-reference)             |                    流水线原子表                   |
|       [T\_ATOM\_APPROVE\_REL](broken-reference)      |                  插件审核关联关系表                  |
|     [T\_ATOM\_BUILD\_APP\_REL](broken-reference)     |              流水线原子构建与编译环境关联关系表              |
|       [T\_ATOM\_BUILD\_INFO](broken-reference)       |                  流水线原子构建信息表                 |
| [T\_ATOM\_DEV\_LANGUAGE\_ENV\_VAR](broken-reference) |                  插件环境变量信息表                  |
|        [T\_ATOM\_ENV\_INFO](broken-reference)        |                 流水线原子执行环境信息表                |
|         [T\_ATOM\_FEATURE](broken-reference)         |                  原子插件特性信息表                  |
|        [T\_ATOM\_LABEL\_REL](broken-reference)       |                  原子与标签关联关系表                 |
|         [T\_ATOM\_OFFLINE](broken-reference)         |                    原子下架表                    |
|       [T\_ATOM\_OPERATE\_LOG](broken-reference)      |                  流水线原子操作日志表                 |
|   [T\_ATOM\_PIPELINE\_BUILD\_REL](broken-reference)  |                 流水线原子构建关联关系表                |
|      [T\_ATOM\_PIPELINE\_REL](broken-reference)      |                流水线原子与流水线关联关系表               |
|       [T\_ATOM\_VERSION\_LOG](broken-reference)      |                  流水线原子版本日志表                 |
|        [T\_BUILD\_RESOURCE](broken-reference)        |                  流水线构建资源信息表                 |
|        [T\_BUSINESS\_CONFIG](broken-reference)       |                  store业务配置表                 |
|            [T\_CATEGORY](broken-reference)           |                    范畴信息表                    |
|            [T\_CLASSIFY](broken-reference)           |                  流水线原子分类信息表                 |
|           [T\_CONTAINER](broken-reference)           | 流水线构建容器表（这里的容器与Docker不是同一个概念，而是流水线模型中的一个元素） |
|    [T\_CONTAINER\_RESOURCE\_REL](broken-reference)   |               流水线容器与构建资源关联关系表               |
|             [T\_IMAGE](broken-reference)             |                    镜像信息表                    |
|       [T\_IMAGE\_AGENT\_TYPE](broken-reference)      |                  镜像与机器类型关联表                 |
|      [T\_IMAGE\_CATEGORY\_REL](broken-reference)     |                  镜像与范畴关联关系表                 |
|         [T\_IMAGE\_FEATURE](broken-reference)        |                    镜像特性表                    |
|       [T\_IMAGE\_LABEL\_REL](broken-reference)       |                  镜像与标签关联关系表                 |
|      [T\_IMAGE\_VERSION\_LOG](broken-reference)      |                   镜像版本日志表                   |
|             [T\_LABEL](broken-reference)             |                   原子标签信息表                   |
|              [T\_LOGO](broken-reference)             |                  商店logo信息表                  |
|             [T\_REASON](broken-reference)            |                    原因定义表                    |
|          [T\_REASON\_REL](broken-reference)          |                  原因和组件关联关系                  |
|         [T\_STORE\_APPROVE](broken-reference)        |                     审核表                     |
|     [T\_STORE\_BUILD\_APP\_REL](broken-reference)    |              store构建与编译环境关联关系表              |
|       [T\_STORE\_BUILD\_INFO](broken-reference)      |                 store组件构建信息表                |
|         [T\_STORE\_COMMENT](broken-reference)        |                 store组件评论信息表                |
|     [T\_STORE\_COMMENT\_PRAISE](broken-reference)    |                store组件评论点赞信息表               |
|     [T\_STORE\_COMMENT\_REPLY](broken-reference)     |                store组件评论回复信息表               |
|        [T\_STORE\_DEPT\_REL](broken-reference)       |                商店组件与与机构关联关系表                |
|        [T\_STORE\_ENV\_VAR](broken-reference)        |                   环境变量信息表                   |
|       [T\_STORE\_MEDIA\_INFO](broken-reference)      |                    媒体信息表                    |
|         [T\_STORE\_MEMBER](broken-reference)         |                 store组件成员信息表                |
|        [T\_STORE\_OPT\_LOG](broken-reference)        |                  store操作日志表                 |
|  [T\_STORE\_PIPELINE\_BUILD\_REL](broken-reference)  |                 商店组件构建关联关系表                 |
|      [T\_STORE\_PIPELINE\_REL](broken-reference)     |                商店组件与与流水线关联关系表               |
|      [T\_STORE\_PROJECT\_REL](broken-reference)      |                 商店组件与项目关联关系表                |
|         [T\_STORE\_RELEASE](broken-reference)        |                store组件发布升级信息表               |
|     [T\_STORE\_SENSITIVE\_API](broken-reference)     |                  敏感API接口信息表                 |
|     [T\_STORE\_SENSITIVE\_CONF](broken-reference)    |                  store私有配置表                 |
|       [T\_STORE\_STATISTICS](broken-reference)       |                  store统计信息表                 |
|    [T\_STORE\_STATISTICS\_DAILY](broken-reference)   |                 store每日统计信息表                |
|    [T\_STORE\_STATISTICS\_TOTAL](broken-reference)   |                 store全量统计信息表                |
|            [T\_TEMPLATE](broken-reference)           |                    模板信息表                    |
|    [T\_TEMPLATE\_CATEGORY\_REL](broken-reference)    |                  模板与范畴关联关系表                 |
|      [T\_TEMPLATE\_LABEL\_REL](broken-reference)     |                  模板与标签关联关系表                 |

**表名：** T\_APPS

**说明：** 编译环境信息表

**数据列：**

|  序号 |     名称    |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明   |
| :-: | :-------: | :-----: | :-: | :-: | :--: | :-: | :-: | :----: |
|  1  |     ID    |   int   |  10 |  0  |   N  |  Y  |     |  主键ID  |
|  2  |    NAME   | varchar |  64 |  0  |   N  |  N  |     |   名称   |
|  3  |     OS    | varchar |  32 |  0  |   N  |  N  |     |  操作系统  |
|  4  | BIN\_PATH | varchar |  64 |  0  |   Y  |  N  |     | 执行所在路径 |

**表名：** T\_APP\_ENV

**说明：** 编译环境变量表

**数据列：**

|  序号 |      名称     |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明   |
| :-: | :---------: | :-----: | :-: | :-: | :--: | :-: | :-: | :----: |
|  1  |      ID     |   int   |  10 |  0  |   N  |  Y  |     |  主键ID  |
|  2  |   APP\_ID   |   int   |  10 |  0  |   N  |  N  |     | 编译环境ID |
|  3  |     PATH    | varchar |  32 |  0  |   N  |  N  |     |   路径   |
|  4  |     NAME    | varchar |  32 |  0  |   N  |  N  |     |   名称   |
|  5  | DESCRIPTION | varchar |  64 |  0  |   N  |  N  |     |   描述   |

**表名：** T\_APP\_VERSION

**说明：** 编译环境版本信息表

**数据列：**

|  序号 |    名称   |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明   |
| :-: | :-----: | :-----: | :-: | :-: | :--: | :-: | :-: | :----: |
|  1  |    ID   |   int   |  10 |  0  |   N  |  Y  |     |  主键ID  |
|  2  | APP\_ID |   int   |  10 |  0  |   N  |  N  |     | 编译环境ID |
|  3  | VERSION | varchar |  32 |  0  |   Y  |  N  |     |   版本号  |

**表名：** T\_ATOM

**说明：** 流水线原子表

**数据列：**

|  序号 |            名称           |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |                  说明                  |
| :-: | :---------------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :----------------------------------: |
|  1  |            ID           |  varchar |   32  |  0  |   N  |  Y  |                    |                 主键ID                 |
|  2  |           NAME          |  varchar |   64  |  0  |   N  |  N  |                    |                  名称                  |
|  3  |        ATOM\_CODE       |  varchar |   64  |  0  |   N  |  N  |                    |                插件的唯一标识               |
|  4  |       CLASS\_TYPE       |  varchar |   64  |  0  |   N  |  N  |                    |                 插件大类                 |
|  5  |      SERVICE\_SCOPE     |  varchar |  256  |  0  |   N  |  N  |                    |                 生效范围                 |
|  6  |        JOB\_TYPE        |  varchar |   20  |  0  |   Y  |  N  |                    | 适用Job类型，AGENT：编译环境，AGENT\_LESS：无编译环境 |
|  7  |            OS           |  varchar |  100  |  0  |   N  |  N  |                    |                 操作系统                 |
|  8  |       CLASSIFY\_ID      |  varchar |   32  |  0  |   N  |  N  |                    |                所属分类ID                |
|  9  |        DOCS\_LINK       |  varchar |  256  |  0  |   Y  |  N  |                    |                文档跳转链接                |
|  10 |        ATOM\_TYPE       |  tinyint |   4   |  0  |   N  |  N  |          1         |                 原子类型                 |
|  11 |       ATOM\_STATUS      |  tinyint |   4   |  0  |   N  |  N  |                    |                 原子状态                 |
|  12 |    ATOM\_STATUS\_MSG    |  varchar |  1024 |  0  |   Y  |  N  |                    |                插件状态信息                |
|  13 |         SUMMARY         |  varchar |  256  |  0  |   Y  |  N  |                    |                  简介                  |
|  14 |       DESCRIPTION       |   text   | 65535 |  0  |   Y  |  N  |                    |                  描述                  |
|  15 |         CATEGROY        |  tinyint |   4   |  0  |   N  |  N  |          1         |                  类别                  |
|  16 |         VERSION         |  varchar |   20  |  0  |   N  |  N  |                    |                  版本号                 |
|  17 |        LOGO\_URL        |  varchar |  256  |  0  |   Y  |  N  |                    |               LOGOURL地址              |
|  18 |           ICON          |   text   | 65535 |  0  |   Y  |  N  |                    |                 插件图标                 |
|  19 |      DEFAULT\_FLAG      |    bit   |   1   |  0  |   N  |  N  |        b'0'        |                是否为默认原子               |
|  20 |       LATEST\_FLAG      |    bit   |   1   |  0  |   N  |  N  |                    |               是否为最新版本原子              |
|  21 |  BUILD\_LESS\_RUN\_FLAG |    bit   |   1   |  0  |   Y  |  N  |                    |         无构建环境原子是否可以在有构建环境运行标识        |
|  22 |   REPOSITORY\_HASH\_ID  |  varchar |   64  |  0  |   Y  |  N  |                    |                代码库哈希ID               |
|  23 |        CODE\_SRC        |  varchar |  256  |  0  |   Y  |  N  |                    |                 代码库链接                |
|  24 |        PAY\_FLAG        |    bit   |   1   |  0  |   Y  |  N  |        b'1'        |                 是否免费                 |
|  25 | HTML\_TEMPLATE\_VERSION |  varchar |   10  |  0  |   N  |  N  |         1.1        |               前端渲染模板版本               |
|  26 |          PROPS          |   text   | 65535 |  0  |   Y  |  N  |                    |         自定义扩展容器前端表单属性字段的JSON串        |
|  27 |           DATA          |   text   | 65535 |  0  |   Y  |  N  |                    |                 预留字段                 |
|  28 |        PUBLISHER        |  varchar |   50  |  0  |   N  |  N  |       system       |                 原子发布者                |
|  29 |          WEIGHT         |    int   |   10  |  0  |   Y  |  N  |                    |                  权值                  |
|  30 |         CREATOR         |  varchar |   50  |  0  |   N  |  N  |       system       |                  创建者                 |
|  31 |         MODIFIER        |  varchar |   50  |  0  |   N  |  N  |       system       |                  修改者                 |
|  32 |       CREATE\_TIME      | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                 创建时间                 |
|  33 |       UPDATE\_TIME      | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                 更新时间                 |
|  34 |    VISIBILITY\_LEVEL    |    int   |   10  |  0  |   N  |  N  |          0         |                 可见范围                 |
|  35 |        PUB\_TIME        | datetime |   19  |  0  |   Y  |  N  |                    |                 发布时间                 |
|  36 |     PRIVATE\_REASON     |  varchar |  256  |  0  |   Y  |  N  |                    |              插件代码库不开源原因              |
|  37 |       DELETE\_FLAG      |    bit   |   1   |  0  |   Y  |  N  |        b'0'        |                 是否删除                 |

**表名：** T\_ATOM\_APPROVE\_REL

**说明：** 插件审核关联关系表

**数据列：**

|  序号 |          名称         |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |    说明   |
| :-: | :-----------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-----: |
|  1  |          ID         |  varchar |  32 |  0  |   N  |  Y  |                    |   主键ID  |
|  2  |      ATOM\_CODE     |  varchar |  64 |  0  |   N  |  N  |                    | 插件的唯一标识 |
|  3  | TEST\_PROJECT\_CODE |  varchar |  32 |  0  |   N  |  N  |                    |  调试项目编码 |
|  4  |     APPROVE\_ID     |  varchar |  32 |  0  |   N  |  N  |                    |   审批ID  |
|  5  |       CREATOR       |  varchar |  50 |  0  |   N  |  N  |       system       |   创建者   |
|  6  |       MODIFIER      |  varchar |  50 |  0  |   N  |  N  |       system       |  最近修改人  |
|  7  |     CREATE\_TIME    | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   创建时间  |
|  8  |     UPDATE\_TIME    | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   更新时间  |

**表名：** T\_ATOM\_BUILD\_APP\_REL

**说明：** 流水线原子构建与编译环境关联关系表

**数据列：**

|  序号 |        名称        |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |               说明              |
| :-: | :--------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :---------------------------: |
|  1  |        ID        |  varchar |  32 |  0  |   N  |  Y  |                    |              主键ID             |
|  2  |  BUILD\_INFO\_ID |  varchar |  32 |  0  |   N  |  N  |                    |             构建信息Id            |
|  3  | APP\_VERSION\_ID |    int   |  10 |  0  |   Y  |  N  |                    | 编译环境版本Id(对应T\_APP\_VERSION主键) |
|  4  |      CREATOR     |  varchar |  50 |  0  |   N  |  N  |       system       |              创建者              |
|  5  |     MODIFIER     |  varchar |  50 |  0  |   N  |  N  |       system       |              修改者              |
|  6  |   CREATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |              创建时间             |
|  7  |   UPDATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |              更新时间             |

**表名：** T\_ATOM\_BUILD\_INFO

**说明：** 流水线原子构建信息表

**数据列：**

|  序号 |           名称          |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |     说明     |
| :-: | :-------------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :--------: |
|  1  |           ID          |  varchar |   32  |  0  |   N  |  Y  |                    |    主键ID    |
|  2  |        LANGUAGE       |  varchar |   64  |  0  |   Y  |  N  |                    |     语言     |
|  3  |         SCRIPT        |   text   | 65535 |  0  |   N  |  N  |                    |    打包脚本    |
|  4  |        CREATOR        |  varchar |   50  |  0  |   N  |  N  |       system       |     创建者    |
|  5  |        MODIFIER       |  varchar |   50  |  0  |   N  |  N  |       system       |     修改者    |
|  6  |      CREATE\_TIME     | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    创建时间    |
|  7  |      UPDATE\_TIME     | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    更新时间    |
|  8  |    REPOSITORY\_PATH   |  varchar |  500  |  0  |   Y  |  N  |                    |   代码存放路径   |
|  9  | SAMPLE\_PROJECT\_PATH |  varchar |  500  |  0  |   N  |  N  |                    |   样例工程路径   |
|  10 |         ENABLE        |    bit   |   1   |  0  |   N  |  N  |        b'1'        | 是否启用1启用0禁用 |

**表名：** T\_ATOM\_DEV\_LANGUAGE\_ENV\_VAR

**说明：** 插件环境变量信息表

**数据列：**

|  序号 |         名称        |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |                                说明                                |
| :-: | :---------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--------------------------------------------------------------: |
|  1  |         ID        |  varchar |  32 |  0  |   N  |  Y  |                    |                                主键                                |
|  2  |      LANGUAGE     |  varchar |  64 |  0  |   N  |  N  |                    |                              插件开发语言                              |
|  3  |      ENV\_KEY     |  varchar |  64 |  0  |   N  |  N  |                    |                             环境变量key值                             |
|  4  |     ENV\_VALUE    |  varchar | 256 |  0  |   N  |  N  |                    |                            环境变量value值                            |
|  5  | BUILD\_HOST\_TYPE |  varchar |  32 |  0  |   N  |  N  |                    |              适用构建机类型PUBLIC:公共构建机，THIRD:第三方构建机，ALL:所有             |
|  6  |  BUILD\_HOST\_OS  |  varchar |  32 |  0  |   N  |  N  |                    | 适用构建机操作系统WINDOWS:windows构建机，LINUX:linux构建机，MAC\_OS:mac构建机，ALL:所有 |
|  7  |      CREATOR      |  varchar |  50 |  0  |   N  |  N  |       system       |                                创建人                               |
|  8  |      MODIFIER     |  varchar |  50 |  0  |   N  |  N  |       system       |                               最近修改人                              |
|  9  |    CREATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                               创建时间                               |
|  10 |    UPDATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                               更新时间                               |

**表名：** T\_ATOM\_ENV\_INFO

**说明：** 流水线原子执行环境信息表

**数据列：**

|  序号 |         名称         |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |       说明      |
| :-: | :----------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :-----------: |
|  1  |         ID         |  varchar |   32  |  0  |   N  |  Y  |                    |      主键ID     |
|  2  |      ATOM\_ID      |  varchar |   32  |  0  |   N  |  N  |                    |      插件Id     |
|  3  |      PKG\_PATH     |  varchar |  1024 |  0  |   N  |  N  |                    |     安装包路径     |
|  4  |      LANGUAGE      |  varchar |   64  |  0  |   Y  |  N  |                    |       语言      |
|  5  |    MIN\_VERSION    |  varchar |   20  |  0  |   Y  |  N  |                    | 支持插件开发语言的最低版本 |
|  6  |       TARGET       |  varchar |  256  |  0  |   N  |  N  |                    |     插件执行入口    |
|  7  |    SHA\_CONTENT    |  varchar |  1024 |  0  |   Y  |  N  |                    |    插件SHA签名串   |
|  8  |      PRE\_CMD      |   text   | 65535 |  0  |   Y  |  N  |                    |    插件执行前置命令   |
|  9  |       CREATOR      |  varchar |   50  |  0  |   N  |  N  |       system       |      创建者      |
|  10 |      MODIFIER      |  varchar |   50  |  0  |   N  |  N  |       system       |      修改者      |
|  11 |    CREATE\_TIME    | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |      创建时间     |
|  12 |    UPDATE\_TIME    | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |      更新时间     |
|  13 |      PKG\_NAME     |  varchar |  256  |  0  |   Y  |  N  |                    |      插件包名     |
|  14 | POST\_ENTRY\_PARAM |  varchar |   64  |  0  |   Y  |  N  |                    |      入口参数     |
|  15 |   POST\_CONDITION  |  varchar |  1024 |  0  |   Y  |  N  |                    |      执行条件     |

**表名：** T\_ATOM\_FEATURE

**说明：** 原子插件特性信息表

**数据列：**

|  序号 |         名称        |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |     说明     |
| :-: | :---------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--------: |
|  1  |         ID        |  varchar |  32 |  0  |   N  |  Y  |                    |    主键ID    |
|  2  |     ATOM\_CODE    |  varchar |  64 |  0  |   N  |  N  |                    |   插件的唯一标识  |
|  3  | VISIBILITY\_LEVEL |    int   |  10 |  0  |   N  |  N  |          0         |    可见范围    |
|  4  |      CREATOR      |  varchar |  50 |  0  |   N  |  N  |       system       |     创建者    |
|  5  |      MODIFIER     |  varchar |  50 |  0  |   N  |  N  |       system       |     修改者    |
|  6  |    CREATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    创建时间    |
|  7  |    UPDATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    更新时间    |
|  8  |  RECOMMEND\_FLAG  |    bit   |  1  |  0  |   Y  |  N  |        b'1'        |    是否推荐    |
|  9  |  PRIVATE\_REASON  |  varchar | 256 |  0  |   Y  |  N  |                    | 插件代码库不开源原因 |
|  10 |    DELETE\_FLAG   |    bit   |  1  |  0  |   Y  |  N  |        b'0'        |    是否删除    |
|  11 |     YAML\_FLAG    |    bit   |  1  |  0  |   Y  |  N  |        b'0'        |  yaml可用标识  |
|  12 |   QUALITY\_FLAG   |    bit   |  1  |  0  |   Y  |  N  |        b'0'        |  质量红线可用标识  |

**表名：** T\_ATOM\_LABEL\_REL

**说明：** 原子与标签关联关系表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |  说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--: |
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    | 主键ID |
|  2  |   LABEL\_ID  |  varchar |  32 |  0  |   N  |  N  |                    | 标签ID |
|  3  |   ATOM\_ID   |  varchar |  32 |  0  |   N  |  N  |                    | 插件Id |
|  4  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |  创建者 |
|  5  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |  修改者 |
|  6  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP | 创建时间 |
|  7  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP | 更新时间 |

**表名：** T\_ATOM\_OFFLINE

**说明：** 原子下架表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |    说明   |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-----: |
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |   主键ID  |
|  2  |  ATOM\_CODE  |  varchar |  64 |  0  |   N  |  N  |                    | 插件的唯一标识 |
|  3  |  BUFFER\_DAY |  tinyint |  4  |  0  |   N  |  N  |                    |         |
|  4  | EXPIRE\_TIME | datetime |  19 |  0  |   N  |  N  |                    |   过期时间  |
|  5  |    STATUS    |  tinyint |  4  |  0  |   N  |  N  |                    |    状态   |
|  6  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |   创建者   |
|  7  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |   修改者   |
|  8  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   创建时间  |
|  9  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   更新时间  |

**表名：** T\_ATOM\_OPERATE\_LOG

**说明：** 流水线原子操作日志表

**数据列：**

|  序号 |      名称      |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |  说明  |
| :-: | :----------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :--: |
|  1  |      ID      |  varchar |   32  |  0  |   N  |  Y  |                    | 主键ID |
|  2  |   ATOM\_ID   |  varchar |   32  |  0  |   N  |  N  |                    | 插件Id |
|  3  |    CONTENT   |   text   | 65535 |  0  |   N  |  N  |                    | 日志内容 |
|  4  |    CREATOR   |  varchar |   50  |  0  |   N  |  N  |       system       |  创建者 |
|  5  |   MODIFIER   |  varchar |   50  |  0  |   N  |  N  |       system       |  修改者 |
|  6  | CREATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP | 创建时间 |
|  7  | UPDATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP | 更新时间 |

**表名：** T\_ATOM\_PIPELINE\_BUILD\_REL

**说明：** 流水线原子构建关联关系表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |   说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :---: |
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |  主键ID |
|  2  |   ATOM\_ID   |  varchar |  32 |  0  |   N  |  N  |                    |  插件Id |
|  3  | PIPELINE\_ID |  varchar |  34 |  0  |   N  |  N  |                    | 流水线ID |
|  4  |   BUILD\_ID  |  varchar |  34 |  0  |   N  |  N  |                    |  构建ID |
|  5  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |  创建者  |
|  6  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |  修改者  |
|  7  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  创建时间 |
|  8  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  更新时间 |

**表名：** T\_ATOM\_PIPELINE\_REL

**说明：** 流水线原子与流水线关联关系表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |    说明   |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-----: |
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |   主键ID  |
|  2  |  ATOM\_CODE  |  varchar |  64 |  0  |   N  |  N  |                    | 插件的唯一标识 |
|  3  | PIPELINE\_ID |  varchar |  34 |  0  |   N  |  N  |                    |  流水线ID  |
|  4  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |   创建者   |
|  5  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |   修改者   |
|  6  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   创建时间  |
|  7  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   更新时间  |

**表名：** T\_ATOM\_VERSION\_LOG

**说明：** 流水线原子版本日志表

**数据列：**

|  序号 |       名称      |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |  说明  |
| :-: | :-----------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :--: |
|  1  |       ID      |  varchar |   32  |  0  |   N  |  Y  |                    | 主键ID |
|  2  |    ATOM\_ID   |  varchar |   32  |  0  |   N  |  N  |                    | 插件Id |
|  3  | RELEASE\_TYPE |  tinyint |   4   |  0  |   N  |  N  |                    | 发布类型 |
|  4  |    CONTENT    |   text   | 65535 |  0  |   N  |  N  |                    | 日志内容 |
|  5  |    CREATOR    |  varchar |   50  |  0  |   N  |  N  |       system       |  创建者 |
|  6  |    MODIFIER   |  varchar |   50  |  0  |   N  |  N  |       system       |  修改者 |
|  7  |  CREATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP | 创建时间 |
|  8  |  UPDATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP | 更新时间 |

**表名：** T\_BUILD\_RESOURCE

**说明：** 流水线构建资源信息表

**数据列：**

|  序号 |           名称          |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |    说明   |
| :-: | :-------------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-----: |
|  1  |           ID          |  varchar |  32 |  0  |   N  |  Y  |                    |   主键ID  |
|  2  | BUILD\_RESOURCE\_CODE |  varchar |  30 |  0  |   N  |  N  |                    |  构建资源代码 |
|  3  | BUILD\_RESOURCE\_NAME |  varchar |  45 |  0  |   N  |  N  |                    |  构建资源名称 |
|  4  |     DEFAULT\_FLAG     |    bit   |  1  |  0  |   N  |  N  |        b'0'        | 是否为默认原子 |
|  5  |        CREATOR        |  varchar |  50 |  0  |   N  |  N  |       system       |   创建者   |
|  6  |        MODIFIER       |  varchar |  50 |  0  |   N  |  N  |       system       |   修改者   |
|  7  |      CREATE\_TIME     | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   创建时间  |
|  8  |      UPDATE\_TIME     | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   更新时间  |

**表名：** T\_BUSINESS\_CONFIG

**说明：** store业务配置表

**数据列：**

|  序号 |        名称       |   数据类型  |   长度  | 小数位 | 允许空值 |  主键 | 默认值 |    说明    |
| :-: | :-------------: | :-----: | :---: | :-: | :--: | :-: | :-: | :------: |
|  1  |     BUSINESS    | varchar |   64  |  0  |   N  |  N  |     |   业务名称   |
|  2  |     FEATURE     | varchar |   64  |  0  |   N  |  N  |     | 要控制的功能特性 |
|  3  | BUSINESS\_VALUE | varchar |  255  |  0  |   N  |  N  |     |   业务取值   |
|  4  |  CONFIG\_VALUE  |   text  | 65535 |  0  |   N  |  N  |     |    配置值   |
|  5  |   DESCRIPTION   | varchar |  255  |  0  |   Y  |  N  |     |   配置描述   |
|  6  |        ID       |   int   |   10  |  0  |   N  |  Y  |     |   主键ID   |

**表名：** T\_CATEGORY

**说明：** 范畴信息表

**数据列：**

|  序号 |       名称       |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |   说明   |
| :-: | :------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :----: |
|  1  |       ID       |  varchar |  32 |  0  |   N  |  Y  |                    |  主键ID  |
|  2  | CATEGORY\_CODE |  varchar |  32 |  0  |   N  |  N  |                    |  范畴代码  |
|  3  | CATEGORY\_NAME |  varchar |  32 |  0  |   N  |  N  |                    |  范畴名称  |
|  4  |    ICON\_URL   |  varchar | 256 |  0  |   Y  |  N  |                    | 范畴图标链接 |
|  5  |      TYPE      |  tinyint |  4  |  0  |   N  |  N  |          0         |   类型   |
|  6  |     CREATOR    |  varchar |  50 |  0  |   N  |  N  |       system       |   创建者  |
|  7  |    MODIFIER    |  varchar |  50 |  0  |   N  |  N  |       system       |   修改者  |
|  8  |  CREATE\_TIME  | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  创建时间  |
|  9  |  UPDATE\_TIME  | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  更新时间  |

**表名：** T\_CLASSIFY

**说明：** 流水线原子分类信息表

**数据列：**

|  序号 |       名称       |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |    说明    |
| :-: | :------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :------: |
|  1  |       ID       |  varchar |  32 |  0  |   N  |  Y  |                    |   主键ID   |
|  2  | CLASSIFY\_CODE |  varchar |  32 |  0  |   N  |  N  |                    | 所属镜像分类代码 |
|  3  | CLASSIFY\_NAME |  varchar |  32 |  0  |   N  |  N  |                    | 所属镜像分类名称 |
|  4  |     WEIGHT     |    int   |  10 |  0  |   Y  |  N  |                    |    权值    |
|  5  |     CREATOR    |  varchar |  50 |  0  |   N  |  N  |       system       |    创建者   |
|  6  |    MODIFIER    |  varchar |  50 |  0  |   N  |  N  |       system       |    修改者   |
|  7  |  CREATE\_TIME  | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   创建时间   |
|  8  |  UPDATE\_TIME  | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |   更新时间   |
|  9  |      TYPE      |  tinyint |  4  |  0  |   N  |  N  |          0         |    类型    |

**表名：** T\_CONTAINER

**说明：** 流水线构建容器表（这里的容器与Docker不是同一个概念，而是流水线模型中的一个元素）

**数据列：**

|  序号 |           名称          |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |           说明          |
| :-: | :-------------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :-------------------: |
|  1  |           ID          |  varchar |   32  |  0  |   N  |  Y  |                    |          主键ID         |
|  2  |          NAME         |  varchar |   45  |  0  |   N  |  N  |                    |           名称          |
|  3  |          TYPE         |  varchar |   20  |  0  |   N  |  N  |                    |           类型          |
|  4  |           OS          |  varchar |   15  |  0  |   N  |  N  |                    |          操作系统         |
|  5  |        REQUIRED       |  tinyint |   4   |  0  |   N  |  N  |          0         |          是否必须         |
|  6  |  MAX\_QUEUE\_MINUTES  |    int   |   10  |  0  |   Y  |  N  |         60         |         最大排队时间        |
|  7  | MAX\_RUNNING\_MINUTES |    int   |   10  |  0  |   Y  |  N  |         600        |         最大运行时间        |
|  8  |         PROPS         |   text   | 65535 |  0  |   Y  |  N  |                    | 自定义扩展容器前端表单属性字段的JSON串 |
|  9  |        CREATOR        |  varchar |   50  |  0  |   N  |  N  |       system       |          创建者          |
|  10 |        MODIFIER       |  varchar |   50  |  0  |   N  |  N  |       system       |          修改者          |
|  11 |      CREATE\_TIME     | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |          创建时间         |
|  12 |      UPDATE\_TIME     | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |          更新时间         |

**表名：** T\_CONTAINER\_RESOURCE\_REL

**说明：** 流水线容器与构建资源关联关系表

**数据列：**

|  序号 |       名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |   说明   |
| :-: | :-----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :----: |
|  1  |       ID      |  varchar |  32 |  0  |   N  |  Y  |                    |  主键ID  |
|  2  | CONTAINER\_ID |  varchar |  32 |  0  |   N  |  N  |                    | 构建容器ID |
|  3  |  RESOURCE\_ID |  varchar |  32 |  0  |   N  |  N  |                    |  资源ID  |
|  4  |    CREATOR    |  varchar |  50 |  0  |   N  |  N  |       system       |   创建者  |
|  5  |    MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |   修改者  |
|  6  |  CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  创建时间  |
|  7  |  UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  更新时间  |

**表名：** T\_IMAGE

**说明：** 镜像信息表

**数据列：**

|  序号 |           名称          |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |                  说明                  |
| :-: | :-------------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :----------------------------------: |
|  1  |           ID          |  varchar |   32  |  0  |   N  |  Y  |                    |                  主键                  |
|  2  |      IMAGE\_NAME      |  varchar |   64  |  0  |   N  |  N  |                    |                 镜像名称                 |
|  3  |      IMAGE\_CODE      |  varchar |   64  |  0  |   N  |  N  |                    |                 镜像代码                 |
|  4  |      CLASSIFY\_ID     |  varchar |   32  |  0  |   N  |  N  |                    |                所属分类ID                |
|  5  |        VERSION        |  varchar |   20  |  0  |   N  |  N  |                    |                  版本号                 |
|  6  |  IMAGE\_SOURCE\_TYPE  |  varchar |   20  |  0  |   N  |  N  |      bkdevops      |      镜像来源，bkdevops：蓝盾源third：第三方源     |
|  7  |    IMAGE\_REPO\_URL   |  varchar |  256  |  0  |   Y  |  N  |                    |                镜像仓库地址                |
|  8  |   IMAGE\_REPO\_NAME   |  varchar |  256  |  0  |   N  |  N  |                    |                镜像在仓库名称               |
|  9  |       TICKET\_ID      |  varchar |  256  |  0  |   Y  |  N  |                    |              ticket身份ID              |
|  10 |     IMAGE\_STATUS     |  tinyint |   4   |  0  |   N  |  N  |                    |              镜像状态，0：初始化              |
|  11 |   IMAGE\_STATUS\_MSG  |  varchar |  1024 |  0  |   Y  |  N  |                    |            状态对应的描述，如上架失败原因           |
|  12 |      IMAGE\_SIZE      |  varchar |   20  |  0  |   N  |  N  |                    |                 镜像大小                 |
|  13 |       IMAGE\_TAG      |  varchar |  256  |  0  |   Y  |  N  |                    |                 镜像tag                |
|  14 |       LOGO\_URL       |  varchar |  256  |  0  |   Y  |  N  |                    |                logo地址                |
|  15 |          ICON         |   text   | 65535 |  0  |   Y  |  N  |                    |            镜像图标(BASE64字符串)           |
|  16 |        SUMMARY        |  varchar |  256  |  0  |   Y  |  N  |                    |                 镜像简介                 |
|  17 |      DESCRIPTION      |   text   | 65535 |  0  |   Y  |  N  |                    |                 镜像描述                 |
|  18 |       PUBLISHER       |  varchar |   50  |  0  |   N  |  N  |       system       |                 镜像发布者                |
|  19 |       PUB\_TIME       | datetime |   19  |  0  |   Y  |  N  |                    |                 发布时间                 |
|  20 |      LATEST\_FLAG     |    bit   |   1   |  0  |   N  |  N  |                    |      是否为最新版本镜像，TRUE：最新FALSE：非最新      |
|  21 |        CREATOR        |  varchar |   50  |  0  |   N  |  N  |       system       |                  创建人                 |
|  22 |        MODIFIER       |  varchar |   50  |  0  |   N  |  N  |       system       |                 最近修改人                |
|  23 |      CREATE\_TIME     | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                 创建时间                 |
|  24 |      UPDATE\_TIME     | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                 更新时间                 |
|  25 |   AGENT\_TYPE\_SCOPE  |  varchar |   64  |  0  |   N  |  N  |         \[]        |               支持的构建机环境               |
|  26 |      DELETE\_FLAG     |    bit   |   1   |  0  |   Y  |  N  |        b'0'        |          删除标识true：是，false：否          |
|  27 |   DOCKER\_FILE\_TYPE  |  varchar |   32  |  0  |   N  |  N  |        INPUT       | dockerFile类型（INPUT：手动输入，\*\_LINK：链接） |
|  28 | DOCKER\_FILE\_CONTENT |   text   | 65535 |  0  |   Y  |  N  |                    |             dockerFile内容             |

**表名：** T\_IMAGE\_AGENT\_TYPE

**说明：** 镜像与机器类型关联表

**数据列：**

|  序号 |      名称     |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |                        说明                       |
| :-: | :---------: | :-----: | :-: | :-: | :--: | :-: | :-: | :---------------------------------------------: |
|  1  |      ID     | varchar |  32 |  0  |   N  |  Y  |     |                        主键                       |
|  2  | IMAGE\_CODE | varchar |  64 |  0  |   N  |  N  |     |                       镜像代码                      |
|  3  | AGENT\_TYPE | varchar |  32 |  0  |   N  |  N  |     | 机器类型PUBLIC\_DEVNET，PUBLIC\_IDC，PUBLIC\_DEVCLOUD |

**表名：** T\_IMAGE\_CATEGORY\_REL

**说明：** 镜像与范畴关联关系表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |   说明   |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :----: |
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |   主键   |
|  2  | CATEGORY\_ID |  varchar |  32 |  0  |   N  |  N  |                    | 镜像范畴ID |
|  3  |   IMAGE\_ID  |  varchar |  32 |  0  |   N  |  N  |                    |  镜像ID  |
|  4  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |   创建人  |
|  5  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |  最近修改人 |
|  6  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  创建时间  |
|  7  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  更新时间  |

**表名：** T\_IMAGE\_FEATURE

**说明：** 镜像特性表

**数据列：**

|  序号 |          名称         |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |           说明           |
| :-: | :-----------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--------------------: |
|  1  |          ID         |  varchar |  32 |  0  |   N  |  Y  |                    |           主键           |
|  2  |     IMAGE\_CODE     |  varchar | 256 |  0  |   N  |  N  |                    |          镜像代码          |
|  3  |     PUBLIC\_FLAG    |    bit   |  1  |  0  |   Y  |  N  |        b'0'        | 是否为公共镜像，TRUE：是FALSE：不是 |
|  4  |   RECOMMEND\_FLAG   |    bit   |  1  |  0  |   Y  |  N  |        b'1'        |   是否推荐，TRUE：是FALSE：不是  |
|  5  |       CREATOR       |  varchar |  50 |  0  |   N  |  N  |       system       |           创建人          |
|  6  |       MODIFIER      |  varchar |  50 |  0  |   N  |  N  |       system       |          最近修改人         |
|  7  |     CREATE\_TIME    | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |          创建时间          |
|  8  |     UPDATE\_TIME    | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |          更新时间          |
|  9  | CERTIFICATION\_FLAG |    bit   |  1  |  0  |   Y  |  N  |        b'0'        |  是否官方认证，TRUE：是FALSE：不是 |
|  10 |        WEIGHT       |    int   |  10 |  0  |   Y  |  N  |                    |     权重（数值越大代表权重越高）     |
|  11 |     IMAGE\_TYPE     |  tinyint |  4  |  0  |   N  |  N  |          1         |    镜像类型：0：蓝鲸官方，1：第三方   |
|  12 |     DELETE\_FLAG    |    bit   |  1  |  0  |   Y  |  N  |        b'0'        |   删除标识true：是，false：否   |

**表名：** T\_IMAGE\_LABEL\_REL

**说明：** 镜像与标签关联关系表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |   说明   |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :----: |
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |   主键   |
|  2  |   LABEL\_ID  |  varchar |  32 |  0  |   N  |  N  |                    | 模板标签ID |
|  3  |   IMAGE\_ID  |  varchar |  32 |  0  |   N  |  N  |                    |  镜像ID  |
|  4  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |   创建人  |
|  5  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |  最近修改人 |
|  6  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  创建时间  |
|  7  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  更新时间  |

**表名：** T\_IMAGE\_VERSION\_LOG

**说明：** 镜像版本日志表

**数据列：**

|  序号 |       名称      |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |                  说明                  |
| :-: | :-----------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :----------------------------------: |
|  1  |       ID      |  varchar |   32  |  0  |   N  |  Y  |                    |                  主键                  |
|  2  |   IMAGE\_ID   |  varchar |   32  |  0  |   N  |  N  |                    |                 镜像ID                 |
|  3  | RELEASE\_TYPE |  tinyint |   4   |  0  |   N  |  N  |                    | 发布类型，0：新上架1：非兼容性升级2：兼容性功能更新3：兼容性问题修正 |
|  4  |    CONTENT    |   text   | 65535 |  0  |   N  |  N  |                    |                版本日志内容                |
|  5  |    CREATOR    |  varchar |   50  |  0  |   N  |  N  |       system       |                  创建人                 |
|  6  |    MODIFIER   |  varchar |   50  |  0  |   N  |  N  |       system       |                 最近修改人                |
|  7  |  CREATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                 创建时间                 |
|  8  |  UPDATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                 更新时间                 |

**表名：** T\_LABEL

**说明：** 原子标签信息表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |   说明   |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :----: |
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |  主键ID  |
|  2  |  LABEL\_CODE |  varchar |  32 |  0  |   N  |  N  |                    | 镜像标签代码 |
|  3  |  LABEL\_NAME |  varchar |  32 |  0  |   N  |  N  |                    |  标签名称  |
|  4  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |   创建者  |
|  5  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |   修改者  |
|  6  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  创建时间  |
|  7  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  更新时间  |
|  8  |     TYPE     |  tinyint |  4  |  0  |   N  |  N  |          0         |   类型   |

**表名：** T\_LOGO

**说明：** 商店logo信息表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |     说明    |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-------: |
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |    主键ID   |
|  2  |     TYPE     |  varchar |  16 |  0  |   N  |  N  |                    |     类型    |
|  3  |   LOGO\_URL  |  varchar | 512 |  0  |   N  |  N  |                    | LOGOURL地址 |
|  4  |     LINK     |  varchar | 512 |  0  |   Y  |  N  |                    |    跳转链接   |
|  5  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |    创建者    |
|  6  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |    修改者    |
|  7  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    创建时间   |
|  8  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    修改时间   |
|  9  |     ORDER    |    int   |  10 |  0  |   N  |  N  |          0         |    显示顺序   |

**表名：** T\_REASON

**说明：** 原因定义表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |   说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :---: |
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |   主键  |
|  2  |     TYPE     |  varchar |  32 |  0  |   N  |  N  |                    |   类型  |
|  3  |    CONTENT   |  varchar | 512 |  0  |   N  |  N  |                    |  日志内容 |
|  4  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |  创建人  |
|  5  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       | 最近修改人 |
|  6  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  创建时间 |
|  7  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  更新时间 |
|  8  |    ENABLE    |    bit   |  1  |  0  |   N  |  N  |        b'1'        |  是否启用 |
|  9  |     ORDER    |    int   |  10 |  0  |   N  |  N  |          0         |  显示顺序 |

**表名：** T\_REASON\_REL

**说明：** 原因和组件关联关系

**数据列：**

|  序号 |      名称      |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |     说明    |
| :-: | :----------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :-------: |
|  1  |      ID      |  varchar |   32  |  0  |   N  |  Y  |                    |     主键    |
|  2  |     TYPE     |  varchar |   32  |  0  |   N  |  N  |                    |     类型    |
|  3  |  STORE\_CODE |  varchar |   64  |  0  |   N  |  N  |                    | store组件编码 |
|  4  |  STORE\_TYPE |  tinyint |   4   |  0  |   N  |  N  |          0         | store组件类型 |
|  5  |  REASON\_ID  |  varchar |   32  |  0  |   N  |  N  |                    |    原因ID   |
|  6  |     NOTE     |   text   | 65535 |  0  |   Y  |  N  |                    |    原因说明   |
|  7  |    CREATOR   |  varchar |   50  |  0  |   N  |  N  |       system       |    创建人    |
|  8  | CREATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    创建时间   |

**表名：** T\_STORE\_APPROVE

**说明：** 审核表

**数据列：**

|  序号 |      名称      |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |     说明    |
| :-: | :----------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :-------: |
|  1  |      ID      |  varchar |   32  |  0  |   N  |  Y  |                    |    主键ID   |
|  2  |  STORE\_CODE |  varchar |   64  |  0  |   N  |  N  |                    | store组件编码 |
|  3  |  STORE\_TYPE |  tinyint |   4   |  0  |   N  |  N  |          0         | store组件类型 |
|  4  |    CONTENT   |   text   | 65535 |  0  |   N  |  N  |                    |    日志内容   |
|  5  |   APPLICANT  |  varchar |   50  |  0  |   N  |  N  |                    |    申请人    |
|  6  |     TYPE     |  varchar |   64  |  0  |   Y  |  N  |                    |     类型    |
|  7  |    STATUS    |  varchar |   64  |  0  |   Y  |  N  |                    |     状态    |
|  8  |   APPROVER   |  varchar |   50  |  0  |   Y  |  N  |                    |    批准人    |
|  9  | APPROVE\_MSG |  varchar |  256  |  0  |   Y  |  N  |                    |    批准信息   |
|  10 |    CREATOR   |  varchar |   50  |  0  |   N  |  N  |       system       |    创建者    |
|  11 |   MODIFIER   |  varchar |   50  |  0  |   N  |  N  |       system       |   最近修改人   |
|  12 | CREATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    创建时间   |
|  13 | UPDATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    更新时间   |

**表名：** T\_STORE\_BUILD\_APP\_REL

**说明：** store构建与编译环境关联关系表

**数据列：**

|  序号 |        名称        |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |                 说明                |
| :-: | :--------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-------------------------------: |
|  1  |        ID        |  varchar |  32 |  0  |   N  |  Y  |                    |                 主键                |
|  2  |  BUILD\_INFO\_ID |  varchar |  32 |  0  |   N  |  N  |                    | 构建信息Id(对应T\_STORE\_BUILD\_INFO主键) |
|  3  | APP\_VERSION\_ID |    int   |  10 |  0  |   Y  |  N  |                    |   编译环境版本Id(对应T\_APP\_VERSION主键)   |
|  4  |      CREATOR     |  varchar |  50 |  0  |   N  |  N  |       system       |                创建人                |
|  5  |     MODIFIER     |  varchar |  50 |  0  |   N  |  N  |       system       |               最近修改人               |
|  6  |   CREATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                创建时间               |
|  7  |   UPDATE\_TIME   | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                更新时间               |

**表名：** T\_STORE\_BUILD\_INFO

**说明：** store组件构建信息表

**数据列：**

|  序号 |           名称          |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |                 说明                |
| :-: | :-------------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :-------------------------------: |
|  1  |           ID          |  varchar |   32  |  0  |   N  |  Y  |                    |                 主键                |
|  2  |        LANGUAGE       |  varchar |   64  |  0  |   Y  |  N  |                    |                开发语言               |
|  3  |         SCRIPT        |   text   | 65535 |  0  |   N  |  N  |                    |                打包脚本               |
|  4  |        CREATOR        |  varchar |   50  |  0  |   N  |  N  |       system       |                创建人                |
|  5  |        MODIFIER       |  varchar |   50  |  0  |   N  |  N  |       system       |               最近修改人               |
|  6  |      CREATE\_TIME     | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                创建时间               |
|  7  |      UPDATE\_TIME     | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |                更新时间               |
|  8  |    REPOSITORY\_PATH   |  varchar |  500  |  0  |   Y  |  N  |                    |               代码存放路径              |
|  9  |         ENABLE        |    bit   |   1   |  0  |   N  |  N  |        b'1'        |             是否启用1启用0禁用            |
|  10 | SAMPLE\_PROJECT\_PATH |  varchar |  500  |  0  |   N  |  N  |                    |               样例工程路径              |
|  11 |      STORE\_TYPE      |  tinyint |   4   |  0  |   N  |  N  |          0         | store组件类型0：插件1：模板2：镜像3：IDE插件4：微扩展 |

**表名：** T\_STORE\_COMMENT

**说明：** store组件评论信息表

**数据列：**

|  序号 |        名称        |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |     说明     |
| :-: | :--------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :--------: |
|  1  |        ID        |  varchar |   32  |  0  |   N  |  Y  |                    |    主键ID    |
|  2  |     STORE\_ID    |  varchar |   32  |  0  |   N  |  N  |                    |   商店组件ID   |
|  3  |    STORE\_CODE   |  varchar |   64  |  0  |   N  |  N  |                    |  store组件编码 |
|  4  | COMMENT\_CONTENT |   text   | 65535 |  0  |   N  |  N  |                    |    评论内容    |
|  5  |  COMMENTER\_DEPT |  varchar |  200  |  0  |   N  |  N  |                    |  评论者组织架构信息 |
|  6  |       SCORE      |    int   |   10  |  0  |   N  |  N  |                    |     评分     |
|  7  |   PRAISE\_COUNT  |    int   |   10  |  0  |   Y  |  N  |          0         |    点赞个数    |
|  8  |   PROFILE\_URL   |  varchar |  256  |  0  |   Y  |  N  |                    | 评论者头像url地址 |
|  9  |    STORE\_TYPE   |  tinyint |   4   |  0  |   N  |  N  |          0         |  store组件类型 |
|  10 |      CREATOR     |  varchar |   50  |  0  |   N  |  N  |       system       |     创建者    |
|  11 |     MODIFIER     |  varchar |   50  |  0  |   N  |  N  |       system       |     修改者    |
|  12 |   CREATE\_TIME   | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    创建时间    |
|  13 |   UPDATE\_TIME   | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    更新时间    |

**表名：** T\_STORE\_COMMENT\_PRAISE

**说明：** store组件评论点赞信息表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |  说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--: |
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    | 主键ID |
|  2  |  COMMENT\_ID |  varchar |  32 |  0  |   N  |  N  |                    | 评论ID |
|  3  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |  创建者 |
|  4  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |  修改者 |
|  5  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP | 创建时间 |
|  6  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP | 更新时间 |

**表名：** T\_STORE\_COMMENT\_REPLY

**说明：** store组件评论回复信息表

**数据列：**

|  序号 |        名称       |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |     说明     |
| :-: | :-------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :--------: |
|  1  |        ID       |  varchar |   32  |  0  |   N  |  Y  |                    |    主键ID    |
|  2  |   COMMENT\_ID   |  varchar |   32  |  0  |   N  |  N  |                    |    评论ID    |
|  3  |  REPLY\_CONTENT |   text   | 65535 |  0  |   Y  |  N  |                    |    回复内容    |
|  4  |   PROFILE\_URL  |  varchar |  256  |  0  |   Y  |  N  |                    | 评论者头像url地址 |
|  5  | REPLY\_TO\_USER |  varchar |   50  |  0  |   Y  |  N  |                    |    被回复者    |
|  6  |  REPLYER\_DEPT  |  varchar |  200  |  0  |   N  |  N  |                    |  回复者组织架构信息 |
|  7  |     CREATOR     |  varchar |   50  |  0  |   N  |  N  |       system       |     创建者    |
|  8  |     MODIFIER    |  varchar |   50  |  0  |   N  |  N  |       system       |     修改者    |
|  9  |   CREATE\_TIME  | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    创建时间    |
|  10 |   UPDATE\_TIME  | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    更新时间    |

**表名：** T\_STORE\_DEPT\_REL

**说明：** 商店组件与与机构关联关系表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度  | 小数位 | 允许空值 |  主键 |         默认值        |     说明     |
| :-: | :----------: | :------: | :--: | :-: | :--: | :-: | :----------------: | :--------: |
|  1  |      ID      |  varchar |  32  |  0  |   N  |  Y  |                    |    主键ID    |
|  2  |  STORE\_CODE |  varchar |  64  |  0  |   N  |  N  |                    |  store组件编码 |
|  3  |   DEPT\_ID   |    int   |  10  |  0  |   N  |  N  |                    | 项目所属二级机构ID |
|  4  |  DEPT\_NAME  |  varchar | 1024 |  0  |   N  |  N  |                    | 项目所属二级机构名称 |
|  5  |    STATUS    |  tinyint |   4  |  0  |   N  |  N  |          0         |     状态     |
|  6  |    COMMENT   |  varchar |  256 |  0  |   Y  |  N  |                    |     评论     |
|  7  |    CREATOR   |  varchar |  50  |  0  |   N  |  N  |       system       |     创建者    |
|  8  |   MODIFIER   |  varchar |  50  |  0  |   N  |  N  |       system       |     修改者    |
|  9  | CREATE\_TIME | datetime |  19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    创建时间    |
|  10 | UPDATE\_TIME | datetime |  19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    更新时间    |
|  11 |  STORE\_TYPE |  tinyint |   4  |  0  |   N  |  N  |          0         |  store组件类型 |

**表名：** T\_STORE\_ENV\_VAR

**说明：** 环境变量信息表

**数据列：**

|  序号 |       名称      |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |              说明              |
| :-: | :-----------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :--------------------------: |
|  1  |       ID      |  varchar |   32  |  0  |   N  |  Y  |                    |              主键              |
|  2  |  STORE\_CODE  |  varchar |   64  |  0  |   N  |  N  |                    |             组件编码             |
|  3  |  STORE\_TYPE  |  tinyint |   4   |  0  |   N  |  N  |          0         | 组件类型0：插件1：模板2：镜像3：IDE插件4：微扩展 |
|  4  |   VAR\_NAME   |  varchar |   64  |  0  |   N  |  N  |                    |              变量名             |
|  5  |   VAR\_VALUE  |   text   | 65535 |  0  |   N  |  N  |                    |              变量值             |
|  6  |   VAR\_DESC   |   text   | 65535 |  0  |   Y  |  N  |                    |              描述              |
|  7  |     SCOPE     |  varchar |   16  |  0  |   N  |  N  |                    |    生效范围TEST：测试PRD：正式ALL：所有   |
|  8  | ENCRYPT\_FLAG |    bit   |   1   |  0  |   Y  |  N  |        b'0'        |      是否加密，TRUE：是FALSE：否      |
|  9  |    VERSION    |    int   |   10  |  0  |   N  |  N  |          1         |              版本号             |
|  10 |    CREATOR    |  varchar |   50  |  0  |   N  |  N  |       system       |              创建人             |
|  11 |    MODIFIER   |  varchar |   50  |  0  |   N  |  N  |       system       |             最近修改人            |
|  12 |  CREATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |             创建时间             |
|  13 |  UPDATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |             更新时间             |

**表名：** T\_STORE\_MEDIA\_INFO

**说明：** 媒体信息表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |          默认值          |                 说明                |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-------------------: | :-------------------------------: |
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                       |                 主键                |
|  2  |  STORE\_CODE |  varchar |  64 |  0  |   N  |  N  |                       |             store组件标识             |
|  3  |  MEDIA\_URL  |  varchar | 256 |  0  |   N  |  N  |                       |               媒体资源链接              |
|  4  |  MEDIA\_TYPE |  varchar |  32 |  0  |   N  |  N  |                       |      媒体资源类型PICTURE:图片VIDEO:视频     |
|  5  |  STORE\_TYPE |  tinyint |  4  |  0  |   N  |  N  |           0           | store组件类型0：插件1：模板2：镜像3：IDE插件4：微扩展 |
|  6  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |         system        |                创建人                |
|  7  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |         system        |               最近修改人               |
|  8  | CREATE\_TIME | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |                创建时间               |
|  9  | UPDATE\_TIME | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |                更新时间               |

**表名：** T\_STORE\_MEMBER

**说明：** store组件成员信息表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |     说明    |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-------: |
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |    主键ID   |
|  2  |  STORE\_CODE |  varchar |  64 |  0  |   N  |  N  |                    | store组件编码 |
|  3  |   USERNAME   |  varchar |  64 |  0  |   N  |  N  |                    |    用户名称   |
|  4  |     TYPE     |  tinyint |  4  |  0  |   N  |  N  |                    |     类型    |
|  5  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |    创建者    |
|  6  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |    修改者    |
|  7  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    创建时间   |
|  8  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    更新时间   |
|  9  |  STORE\_TYPE |  tinyint |  4  |  0  |   N  |  N  |          0         | store组件类型 |

**表名：** T\_STORE\_OPT\_LOG

**说明：** store操作日志表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |     说明    |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-------: |
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |    主键ID   |
|  2  |  STORE\_CODE |  varchar |  64 |  0  |   N  |  N  |                    | store组件编码 |
|  3  |  STORE\_TYPE |  tinyint |  4  |  0  |   N  |  N  |          0         | store组件类型 |
|  4  |   OPT\_TYPE  |  varchar |  64 |  0  |   N  |  N  |                    |    操作类型   |
|  5  |   OPT\_DESC  |  varchar | 512 |  0  |   N  |  N  |                    |    操作内容   |
|  6  |   OPT\_USER  |  varchar |  64 |  0  |   N  |  N  |                    |    操作用户   |
|  7  |   OPT\_TIME  | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    操作时间   |
|  8  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |    创建者    |
|  9  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    创建时间   |

**表名：** T\_STORE\_PIPELINE\_BUILD\_REL

**说明：** 商店组件构建关联关系表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |   说明   |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :----: |
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |   主键   |
|  2  |   STORE\_ID  |  varchar |  32 |  0  |   N  |  N  |                    | 商店组件ID |
|  3  | PIPELINE\_ID |  varchar |  34 |  0  |   N  |  N  |                    |  流水线ID |
|  4  |   BUILD\_ID  |  varchar |  34 |  0  |   N  |  N  |                    |  构建ID  |
|  5  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |   创建人  |
|  6  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |  最近修改人 |
|  7  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  创建时间  |
|  8  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  更新时间  |

**表名：** T\_STORE\_PIPELINE\_REL

**说明：** 商店组件与与流水线关联关系表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |             说明            |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-----------------------: |
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |             主键            |
|  2  |  STORE\_CODE |  varchar |  64 |  0  |   N  |  N  |                    |           商店组件编码          |
|  3  | PIPELINE\_ID |  varchar |  34 |  0  |   N  |  N  |                    |           流水线ID           |
|  4  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |            创建人            |
|  5  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |           最近修改人           |
|  6  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |            创建时间           |
|  7  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |            更新时间           |
|  8  |  STORE\_TYPE |  tinyint |  4  |  0  |   N  |  N  |          0         | 商店组件类型0：插件1：模板2：镜像3：IDE插件 |

**表名：** T\_STORE\_PROJECT\_REL

**说明：** 商店组件与项目关联关系表

**数据列：**

|  序号 |       名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |     说明    |
| :-: | :-----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-------: |
|  1  |       ID      |  varchar |  32 |  0  |   N  |  Y  |                    |    主键ID   |
|  2  |  STORE\_CODE  |  varchar |  64 |  0  |   N  |  N  |                    | store组件编码 |
|  3  | PROJECT\_CODE |  varchar |  32 |  0  |   N  |  N  |                    |  用户组所属项目  |
|  4  |      TYPE     |  tinyint |  4  |  0  |   N  |  N  |                    |     类型    |
|  5  |    CREATOR    |  varchar |  50 |  0  |   N  |  N  |       system       |    创建者    |
|  6  |    MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |    修改者    |
|  7  |  CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    创建时间   |
|  8  |  UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    更新时间   |
|  9  |  STORE\_TYPE  |  tinyint |  4  |  0  |   N  |  N  |          0         | store组件类型 |

**表名：** T\_STORE\_RELEASE

**说明：** store组件发布升级信息表

**数据列：**

|  序号 |           名称          |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |              说明              |
| :-: | :-------------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--------------------------: |
|  1  |           ID          |  varchar |  32 |  0  |   N  |  Y  |                    |              主键              |
|  2  |      STORE\_CODE      |  varchar |  64 |  0  |   N  |  N  |                    |           store组件代码          |
|  3  |  FIRST\_PUB\_CREATOR  |  varchar |  64 |  0  |   N  |  N  |                    |             首次发布人            |
|  4  |    FIRST\_PUB\_TIME   | datetime |  19 |  0  |   N  |  N  |                    |            首次发布时间            |
|  5  |    LATEST\_UPGRADER   |  varchar |  64 |  0  |   N  |  N  |                    |             最近升级人            |
|  6  | LATEST\_UPGRADE\_TIME | datetime |  19 |  0  |   N  |  N  |                    |            最近升级时间            |
|  7  |      STORE\_TYPE      |  tinyint |  4  |  0  |   N  |  N  |          0         | store组件类型0：插件1：模板2：镜像3：IDE插件 |
|  8  |        CREATOR        |  varchar |  64 |  0  |   N  |  N  |       system       |              创建人             |
|  9  |        MODIFIER       |  varchar |  64 |  0  |   N  |  N  |       system       |             最近修改人            |
|  10 |      CREATE\_TIME     | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |             创建时间             |
|  11 |      UPDATE\_TIME     | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |             更新时间             |

**表名：** T\_STORE\_SENSITIVE\_API

**说明：** 敏感API接口信息表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度  | 小数位 | 允许空值 |  主键 |         默认值        |     说明    |
| :-: | :----------: | :------: | :--: | :-: | :--: | :-: | :----------------: | :-------: |
|  1  |      ID      |  varchar |  32  |  0  |   N  |  Y  |                    |    主键ID   |
|  2  |  STORE\_CODE |  varchar |  64  |  0  |   N  |  N  |                    | store组件编码 |
|  3  |  STORE\_TYPE |  tinyint |   4  |  0  |   N  |  N  |          0         | store组件类型 |
|  4  |   API\_NAME  |  varchar |  64  |  0  |   N  |  N  |                    |   API名称   |
|  5  |  ALIAS\_NAME |  varchar |  64  |  0  |   N  |  N  |                    |     别名    |
|  6  |  API\_STATUS |  varchar |  64  |  0  |   N  |  N  |                    |   API状态   |
|  7  |  API\_LEVEL  |  varchar |  64  |  0  |   N  |  N  |                    |   API等级   |
|  8  |  APPLY\_DESC |  varchar | 1024 |  0  |   Y  |  N  |                    |    申请说明   |
|  9  | APPROVE\_MSG |  varchar | 1024 |  0  |   Y  |  N  |                    |    批准信息   |
|  10 |    CREATOR   |  varchar |  50  |  0  |   N  |  N  |                    |    创建者    |
|  11 |   MODIFIER   |  varchar |  50  |  0  |   N  |  N  |                    |    修改者    |
|  12 | CREATE\_TIME | datetime |  19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    创建时间   |
|  13 | UPDATE\_TIME | datetime |  19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    更新时间   |

**表名：** T\_STORE\_SENSITIVE\_CONF

**说明：** store私有配置表

**数据列：**

|  序号 |      名称      |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |     说明    |
| :-: | :----------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :-------: |
|  1  |      ID      |  varchar |   32  |  0  |   N  |  Y  |                    |    主键ID   |
|  2  |  STORE\_CODE |  varchar |   64  |  0  |   N  |  N  |                    | store组件编码 |
|  3  |  STORE\_TYPE |  tinyint |   4   |  0  |   N  |  N  |          0         | store组件类型 |
|  4  |  FIELD\_NAME |  varchar |   64  |  0  |   N  |  N  |                    |    字段名称   |
|  5  | FIELD\_VALUE |   text   | 65535 |  0  |   N  |  N  |                    |    字段值    |
|  6  |  FIELD\_DESC |   text   | 65535 |  0  |   Y  |  N  |                    |    字段描述   |
|  7  |    CREATOR   |  varchar |   50  |  0  |   N  |  N  |       system       |    创建者    |
|  8  |   MODIFIER   |  varchar |   50  |  0  |   N  |  N  |       system       |    修改者    |
|  9  | CREATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    创建时间   |
|  10 | UPDATE\_TIME | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    更新时间   |
|  11 |  FIELD\_TYPE |  varchar |   16  |  0  |   Y  |  N  |       BACKEND      |    字段类型   |

**表名：** T\_STORE\_STATISTICS

**说明：** store统计信息表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |     说明    |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-------: |
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |    主键ID   |
|  2  |   STORE\_ID  |  varchar |  32 |  0  |   N  |  N  |                    |   商店组件ID  |
|  3  |  STORE\_CODE |  varchar |  64 |  0  |   N  |  N  |                    | store组件编码 |
|  4  |   DOWNLOADS  |    int   |  10 |  0  |   Y  |  N  |                    |    下载量    |
|  5  |    COMMITS   |    int   |  10 |  0  |   Y  |  N  |                    |    评论数量   |
|  6  |     SCORE    |    int   |  10 |  0  |   Y  |  N  |                    |     评分    |
|  7  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |    创建者    |
|  8  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |    修改者    |
|  9  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    创建时间   |
|  10 | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    更新时间   |
|  11 |  STORE\_TYPE |  tinyint |  4  |  0  |   N  |  N  |          0         | store组件类型 |

**表名：** T\_STORE\_STATISTICS\_DAILY

**说明：** store每日统计信息表

**数据列：**

|  序号 |          名称         |   数据类型   |  长度  | 小数位 | 允许空值 |  主键 |          默认值          |    说明    |
| :-: | :-----------------: | :------: | :--: | :-: | :--: | :-: | :-------------------: | :------: |
|  1  |          ID         |  varchar |  32  |  0  |   N  |  Y  |                       |    主键    |
|  2  |     STORE\_CODE     |  varchar |  64  |  0  |   N  |  N  |                       |   组件编码   |
|  3  |     STORE\_TYPE     |  tinyint |   4  |  0  |   N  |  N  |           0           |   组件类型   |
|  4  |   TOTAL\_DOWNLOADS  |    int   |  10  |  0  |   Y  |  N  |           0           |   总下载量   |
|  5  |   DAILY\_DOWNLOADS  |    int   |  10  |  0  |   Y  |  N  |           0           |   每日下载量  |
|  6  | DAILY\_SUCCESS\_NUM |    int   |  10  |  0  |   Y  |  N  |           0           |  每日执行成功数 |
|  7  |   DAILY\_FAIL\_NUM  |    int   |  10  |  0  |   Y  |  N  |           0           | 每日执行失败总数 |
|  8  | DAILY\_FAIL\_DETAIL |  varchar | 4096 |  0  |   Y  |  N  |                       | 每日执行失败详情 |
|  9  |   STATISTICS\_TIME  | datetime |  23  |  0  |   N  |  N  |                       |   统计时间   |
|  10 |     CREATE\_TIME    | datetime |  23  |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |   创建时间   |
|  11 |     UPDATE\_TIME    | datetime |  23  |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |   更新时间   |

**表名：** T\_STORE\_STATISTICS\_TOTAL

**说明：** store全量统计信息表

**数据列：**

|  序号 |          名称          |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |     说明    |
| :-: | :------------------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :-------: |
|  1  |          ID          |  varchar |  32 |  0  |   N  |  Y  |                    |    主键ID   |
|  2  |      STORE\_CODE     |  varchar |  64 |  0  |   N  |  N  |                    | store组件编码 |
|  3  |      STORE\_TYPE     |  tinyint |  4  |  0  |   N  |  N  |          0         | store组件类型 |
|  4  |       DOWNLOADS      |    int   |  10 |  0  |   Y  |  N  |          0         |    下载量    |
|  5  |        COMMITS       |    int   |  10 |  0  |   Y  |  N  |          0         |    评论数量   |
|  6  |         SCORE        |    int   |  10 |  0  |   Y  |  N  |          0         |     评分    |
|  7  |    SCORE\_AVERAGE    |  decimal |  4  |  1  |   Y  |  N  |         0.0        |    评论均分   |
|  8  |     PIPELINE\_NUM    |    int   |  10 |  0  |   Y  |  N  |          0         |   流水线数量   |
|  9  | RECENT\_EXECUTE\_NUM |    int   |  10 |  0  |   Y  |  N  |          0         |   最近执行次数  |
|  10 |     CREATE\_TIME     | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    创建时间   |
|  11 |     UPDATE\_TIME     | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    更新时间   |

**表名：** T\_TEMPLATE

**说明：** 模板信息表

**数据列：**

|  序号 |           名称          |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |     说明    |
| :-: | :-------------------: | :------: | :---: | :-: | :--: | :-: | :----------------: | :-------: |
|  1  |           ID          |  varchar |   32  |  0  |   N  |  Y  |                    |    主键ID   |
|  2  |     TEMPLATE\_NAME    |  varchar |  200  |  0  |   N  |  N  |                    |    模板名称   |
|  3  |     TEMPLATE\_CODE    |  varchar |   32  |  0  |   N  |  N  |                    |    模板代码   |
|  4  |      CLASSIFY\_ID     |  varchar |   32  |  0  |   N  |  N  |                    |   所属分类ID  |
|  5  |        VERSION        |  varchar |   20  |  0  |   N  |  N  |                    |    版本号    |
|  6  |     TEMPLATE\_TYPE    |  tinyint |   4   |  0  |   N  |  N  |          1         |    模板类型   |
|  7  |   TEMPLATE\_RD\_TYPE  |  tinyint |   4   |  0  |   N  |  N  |          1         |   模板研发类型  |
|  8  |    TEMPLATE\_STATUS   |  tinyint |   4   |  0  |   N  |  N  |                    |    模板状态   |
|  9  | TEMPLATE\_STATUS\_MSG |  varchar |  1024 |  0  |   Y  |  N  |                    |   模板状态信息  |
|  10 |       LOGO\_URL       |  varchar |  256  |  0  |   Y  |  N  |                    | LOGOURL地址 |
|  11 |        SUMMARY        |  varchar |  256  |  0  |   Y  |  N  |                    |     简介    |
|  12 |      DESCRIPTION      |   text   | 65535 |  0  |   Y  |  N  |                    |     描述    |
|  13 |       PUBLISHER       |  varchar |   50  |  0  |   N  |  N  |       system       |   原子发布者   |
|  14 |    PUB\_DESCRIPTION   |   text   | 65535 |  0  |   Y  |  N  |                    |    发布描述   |
|  15 |      PUBLIC\_FLAG     |    bit   |   1   |  0  |   N  |  N  |        b'0'        |  是否为公共镜像  |
|  16 |      LATEST\_FLAG     |    bit   |   1   |  0  |   N  |  N  |                    | 是否为最新版本原子 |
|  17 |        CREATOR        |  varchar |   50  |  0  |   N  |  N  |       system       |    创建者    |
|  18 |        MODIFIER       |  varchar |   50  |  0  |   N  |  N  |       system       |    修改者    |
|  19 |      CREATE\_TIME     | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    创建时间   |
|  20 |      UPDATE\_TIME     | datetime |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    更新时间   |
|  21 |       PUB\_TIME       | datetime |   19  |  0  |   Y  |  N  |                    |    发布时间   |

**表名：** T\_TEMPLATE\_CATEGORY\_REL

**说明：** 模板与范畴关联关系表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |   说明   |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :----: |
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    |  主键ID  |
|  2  | CATEGORY\_ID |  varchar |  32 |  0  |   N  |  N  |                    | 镜像范畴ID |
|  3  | TEMPLATE\_ID |  varchar |  32 |  0  |   N  |  N  |                    |  模板ID  |
|  4  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |   创建者  |
|  5  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |   修改者  |
|  6  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  创建时间  |
|  7  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |  更新时间  |

**表名：** T\_TEMPLATE\_LABEL\_REL

**说明：** 模板与标签关联关系表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |  说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--: |
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    | 主键ID |
|  2  |   LABEL\_ID  |  varchar |  32 |  0  |   N  |  N  |                    | 标签ID |
|  3  | TEMPLATE\_ID |  varchar |  32 |  0  |   N  |  N  |                    | 模板ID |
|  4  |    CREATOR   |  varchar |  50 |  0  |   N  |  N  |       system       |  创建者 |
|  5  |   MODIFIER   |  varchar |  50 |  0  |   N  |  N  |       system       |  修改者 |
|  6  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP | 创建时间 |
|  7  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP | 更新时间 |
