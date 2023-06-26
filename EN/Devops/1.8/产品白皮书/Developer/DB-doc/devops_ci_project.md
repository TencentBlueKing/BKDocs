# devops\_ci\_project

**数据库名：** devops\_ci\_project

**文档版本：** 1.0.0

**文档描述：** devops\_ci\_project的数据库文档

|                              表名                             |    说明    |
| :---------------------------------------------------------: | :------: |
|               [T\_ACTIVITY](broken-reference)               |          |
|               [T\_FAVORITE](broken-reference)               |   关注收藏表  |
|              [T\_GRAY\_TEST](broken-reference)              |          |
|         [T\_MESSAGE\_CODE\_DETAIL](broken-reference)        | code码详情表 |
|                [T\_NOTICE](broken-reference)                |          |
|                [T\_PROJECT](broken-reference)               |   项目信息表  |
|            [T\_PROJECT\_LABEL](broken-reference)            |          |
|          [T\_PROJECT\_LABEL\_REL](broken-reference)         |          |
|                [T\_SERVICE](broken-reference)               |   服务信息表  |
|             [T\_SERVICE\_TYPE](broken-reference)            |   服务类型表  |
|                 [T\_USER](broken-reference)                 |    用户表   |
| [T\_USER\_DAILY\_FIRST\_AND\_LAST\_LOGIN](broken-reference) |          |
|          [T\_USER\_DAILY\_LOGIN](broken-reference)          |          |

**表名：** T\_ACTIVITY

**说明：**

**数据列：**

|  序号 |       名称      |   数据类型   |  长度  | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :-----------: | :------: | :--: | :-: | :--: | :-: | :-: | :--: |
|  1  |       ID      |  bigint  |  20  |  0  |   N  |  Y  |     | 主键ID |
|  2  |      TYPE     |  varchar |  32  |  0  |   N  |  N  |     |  类型  |
|  3  |      NAME     |  varchar |  128 |  0  |   N  |  N  |     |  名称  |
|  4  | ENGLISH\_NAME |  varchar |  128 |  0  |   Y  |  N  |     | 英文名称 |
|  5  |      LINK     |  varchar | 1024 |  0  |   N  |  N  |     | 跳转链接 |
|  6  |  CREATE\_TIME | datetime |  19  |  0  |   N  |  N  |     | 创建时间 |
|  7  |     STATUS    |  varchar |  32  |  0  |   N  |  N  |     |  状态  |
|  8  |    CREATOR    |  varchar |  32  |  0  |   N  |  N  |     |  创建者 |

**表名：** T\_FAVORITE

**说明：** 关注收藏表

**数据列：**

|  序号 |      名称     |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :---------: | :-----: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |      id     |  bigint |  20 |  0  |   N  |  Y  |     | 主键id |
|  2  | service\_id |  bigint |  20 |  0  |   Y  |  N  |     | 服务id |
|  3  |   username  | varchar |  64 |  0  |   Y  |  N  |     |  用户  |

**表名：** T\_GRAY\_TEST

**说明：**

**数据列：**

|  序号 |      名称     |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :---------: | :-----: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |      id     |  bigint |  20 |  0  |   N  |  Y  |     | 主键id |
|  2  | service\_id |  bigint |  20 |  0  |   Y  |  N  |     | 服务id |
|  3  |   username  | varchar |  64 |  0  |   Y  |  N  |     |  用户  |
|  4  |    status   | varchar |  64 |  0  |   Y  |  N  |     | 服务状态 |

**表名：** T\_MESSAGE\_CODE\_DETAIL

**说明：** code码详情表

**数据列：**

|  序号 |            名称           |   数据类型  |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |    说明    |
| :-: | :---------------------: | :-----: | :-: | :-: | :--: | :-: | :-: | :------: |
|  1  |            ID           | varchar |  32 |  0  |   N  |  Y  |     |    主键    |
|  2  |      MESSAGE\_CODE      | varchar | 128 |  0  |   N  |  N  |     |   code码  |
|  3  |       MODULE\_CODE      |   char  |  2  |  0  |   N  |  N  |     |   模块代码   |
|  4  | MESSAGE\_DETAIL\_ZH\_CN | varchar | 500 |  0  |   N  |  N  |     | 中文简体描述信息 |
|  5  | MESSAGE\_DETAIL\_ZH\_TW | varchar | 500 |  0  |   Y  |  N  |     | 中文繁体描述信息 |
|  6  |   MESSAGE\_DETAIL\_EN   | varchar | 500 |  0  |   Y  |  N  |     |  英文描述信息  |

**表名：** T\_NOTICE

**说明：**

**数据列：**

|  序号 |        名称       |    数据类型   |   长度  | 小数位 | 允许空值 |  主键 |         默认值        |       说明       |
| :-: | :-------------: | :-------: | :---: | :-: | :--: | :-: | :----------------: | :------------: |
|  1  |        ID       |   bigint  |   20  |  0  |   N  |  Y  |                    |      主键ID      |
|  2  |  NOTICE\_TITLE  |  varchar  |  100  |  0  |   N  |  N  |                    |      公告标题      |
|  3  |   EFFECT\_DATE  | timestamp |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |      生效日期      |
|  4  |  INVALID\_DATE  | timestamp |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |      失效日期      |
|  5  |   CREATE\_DATE  | timestamp |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |      创建日期      |
|  6  |   UPDATE\_DATE  | timestamp |   19  |  0  |   N  |  N  | CURRENT\_TIMESTAMP |      更新日期      |
|  7  | NOTICE\_CONTENT |    text   | 65535 |  0  |   N  |  N  |                    |      公告内容      |
|  8  |  REDIRECT\_URL  |  varchar  |  200  |  0  |   Y  |  N  |                    |      跳转地址      |
|  9  |   NOTICE\_TYPE  |  tinyint  |   4   |  0  |   N  |  N  |          0         | 消息类型:0.弹框1.跑马灯 |

**表名：** T\_PROJECT

**说明：** 项目信息表

**数据列：**

|  序号 |            名称            |    数据类型   |   长度  | 小数位 | 允许空值 |  主键 |  默认值 |       说明      |
| :-: | :----------------------: | :-------: | :---: | :-: | :--: | :-: | :--: | :-----------: |
|  1  |            ID            |   bigint  |   20  |  0  |   N  |  Y  |      |      主键ID     |
|  2  |        created\_at       | timestamp |   19  |  0  |   Y  |  N  |      |      创建时间     |
|  3  |        updated\_at       | timestamp |   19  |  0  |   Y  |  N  |      |      更新时间     |
|  4  |        deleted\_at       | timestamp |   19  |  0  |   Y  |  N  |      |      删除时间     |
|  5  |           extra          |    text   | 65535 |  0  |   Y  |  N  |      |      额外信息     |
|  6  |          creator         |  varchar  |   32  |  0  |   Y  |  N  |      |      创建者      |
|  7  |        description       |    text   | 65535 |  0  |   Y  |  N  |      |       描述      |
|  8  |           kind           |    int    |   10  |  0  |   Y  |  N  |      |      容器类型     |
|  9  |        cc\_app\_id       |   bigint  |   20  |  0  |   Y  |  N  |      |      应用ID     |
|  10 |       cc\_app\_name      |  varchar  |   64  |  0  |   Y  |  N  |      |      应用名称     |
|  11 |       is\_offlined       |    bit    |   1   |  0  |   Y  |  N  | b'0' |      是否停用     |
|  12 |        PROJECT\_ID       |  varchar  |   32  |  0  |   N  |  N  |      |      项目ID     |
|  13 |       project\_name      |  varchar  |   64  |  0  |   N  |  N  |      |      项目名称     |
|  14 |       english\_name      |  varchar  |   64  |  0  |   N  |  N  |      |      英文名称     |
|  15 |          updator         |  varchar  |   32  |  0  |   Y  |  N  |      |      更新人      |
|  16 |       project\_type      |    int    |   10  |  0  |   Y  |  N  |      |      项目类型     |
|  17 |          use\_bk         |    bit    |   1   |  0  |   Y  |  N  | b'1' |     是否用蓝鲸     |
|  18 |       deploy\_type       |    text   | 65535 |  0  |   Y  |  N  |      |      部署类型     |
|  19 |          bg\_id          |   bigint  |   20  |  0  |   Y  |  N  |      |     事业群ID     |
|  20 |         bg\_name         |  varchar  |  255  |  0  |   Y  |  N  |      |     事业群名称     |
|  21 |         dept\_id         |   bigint  |   20  |  0  |   Y  |  N  |      |   项目所属二级机构ID  |
|  22 |        dept\_name        |  varchar  |  255  |  0  |   Y  |  N  |      |   项目所属二级机构名称  |
|  23 |        center\_id        |   bigint  |   20  |  0  |   Y  |  N  |      |      中心ID     |
|  24 |       center\_name       |  varchar  |  255  |  0  |   Y  |  N  |      |      中心名字     |
|  25 |         data\_id         |   bigint  |   20  |  0  |   Y  |  N  |      |      数据ID     |
|  26 |        is\_secrecy       |    bit    |   1   |  0  |   Y  |  N  | b'0' |      是否保密     |
|  27 | is\_helm\_chart\_enabled |    bit    |   1   |  0  |   Y  |  N  | b'0' |    是否启用图表激活   |
|  28 |     approval\_status     |    int    |   10  |  0  |   Y  |  N  |   1  |      审核状态     |
|  29 |        logo\_addr        |    text   | 65535 |  0  |   Y  |  N  |      |     logo地址    |
|  30 |         approver         |  varchar  |   32  |  0  |   Y  |  N  |      |      批准人      |
|  31 |          remark          |    text   | 65535 |  0  |   Y  |  N  |      |       评论      |
|  32 |      approval\_time      | timestamp |   19  |  0  |   Y  |  N  |      |      批准时间     |
|  33 |     creator\_bg\_name    |  varchar  |  128  |  0  |   Y  |  N  |      |    创建者事业群名称   |
|  34 |    creator\_dept\_name   |  varchar  |  128  |  0  |   Y  |  N  |      | 创建者项目所属二级机构名称 |
|  35 |   creator\_center\_name  |  varchar  |  128  |  0  |   Y  |  N  |      |    创建者中心名字    |
|  36 |    hybrid\_cc\_app\_id   |   bigint  |   20  |  0  |   Y  |  N  |      |      应用ID     |
|  37 |     enable\_external     |    bit    |   1   |  0  |   Y  |  N  |      |  是否支持构建机访问外网  |
|  38 |        enable\_idc       |    bit    |   1   |  0  |   Y  |  N  |      |   是否支持IDC构建机  |
|  39 |          enabled         |    bit    |   1   |  0  |   Y  |  N  |      |      是否启用     |
|  40 |          CHANNEL         |  varchar  |   32  |  0  |   N  |  N  |  BS  |      项目渠道     |
|  41 |      pipeline\_limit     |    int    |   10  |  0  |   Y  |  N  |  500 |    流水线数量上限    |
|  42 |        router\_tag       |  varchar  |   32  |  0  |   Y  |  N  |      |    网关路由tags   |
|  43 |       relation\_id       |  varchar  |   32  |  0  |   Y  |  N  |      |    扩展系统关联ID   |

**表名：** T\_PROJECT\_LABEL

**说明：**

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |  说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--: |
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    | 主键ID |
|  2  |  LABEL\_NAME |  varchar |  45 |  0  |   N  |  N  |                    | 标签名称 |
|  3  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP | 创建时间 |
|  4  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP | 修改时间 |

**表名：** T\_PROJECT\_LABEL\_REL

**说明：**

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |  说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--: |
|  1  |      ID      |  varchar |  32 |  0  |   N  |  Y  |                    | 主键ID |
|  2  |   LABEL\_ID  |  varchar |  32 |  0  |   N  |  N  |                    | 标签ID |
|  3  |  PROJECT\_ID |  varchar |  32 |  0  |   N  |  N  |                    | 项目ID |
|  4  | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP | 创建时间 |
|  5  | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP | 修改时间 |

**表名：** T\_SERVICE

**说明：** 服务信息表

**数据列：**

|  序号 |          名称         |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |  默认值 |       说明       |
| :-: | :-----------------: | :------: | :---: | :-: | :--: | :-: | :--: | :------------: |
|  1  |          id         |  bigint  |   20  |  0  |   N  |  Y  |      |       id       |
|  2  |         name        |  varchar |   64  |  0  |   Y  |  N  |      |       名称       |
|  3  |    english\_name    |  varchar |   64  |  0  |   Y  |  N  |      |      英文名称      |
|  4  |  service\_type\_id  |  bigint  |   20  |  0  |   Y  |  N  |      |     服务类型ID     |
|  5  |         link        |  varchar |  255  |  0  |   Y  |  N  |      |      跳转链接      |
|  6  |      link\_new      |  varchar |  255  |  0  |   Y  |  N  |      |      新跳转链接     |
|  7  |     inject\_type    |  varchar |   64  |  0  |   Y  |  N  |      |      注入类型      |
|  8  |     iframe\_url     |  varchar |  255  |  0  |   Y  |  N  |      |   iframeUrl地址  |
|  9  |       css\_url      |  varchar |  255  |  0  |   Y  |  N  |      |    cssUrl地址    |
|  10 |       js\_url       |  varchar |  255  |  0  |   Y  |  N  |      |     jsUrl地址    |
|  11 | show\_project\_list |    bit   |   1   |  0  |   Y  |  N  |      |     是否在页面显示    |
|  12 |      show\_nav      |    bit   |   1   |  0  |   Y  |  N  |      |     showNav    |
|  13 |  project\_id\_type  |  varchar |   64  |  0  |   Y  |  N  |      |     项目ID类型     |
|  14 |        status       |  varchar |   64  |  0  |   Y  |  N  |      |       状态       |
|  15 |    created\_user    |  varchar |   64  |  0  |   Y  |  N  |      |       创建者      |
|  16 |    created\_time    | datetime |   19  |  0  |   Y  |  N  |      |      创建时间      |
|  17 |    updated\_user    |  varchar |   64  |  0  |   Y  |  N  |      |       修改者      |
|  18 |    updated\_time    | datetime |   19  |  0  |   Y  |  N  |      |      修改时间      |
|  19 |       deleted       |    bit   |   1   |  0  |   Y  |  N  |      |      是否删除      |
|  20 |    gray\_css\_url   |  varchar |  255  |  0  |   Y  |  N  |      |   灰度cssUrl地址   |
|  21 |    gray\_js\_url    |  varchar |  255  |  0  |   Y  |  N  |      |    灰度jsUrl地址   |
|  22 |      logo\_url      |  varchar |  256  |  0  |   Y  |  N  |      |     logo地址     |
|  23 |     web\_socket     |   text   | 65535 |  0  |   Y  |  N  |      | 支持webSocket的页面 |
|  24 |        weight       |    int   |   10  |  0  |   Y  |  N  |      |       权值       |
|  25 |  gray\_iframe\_url  |  varchar |  255  |  0  |   Y  |  N  |      |  灰度iframeUrl地址 |
|  26 |     new\_window     |    bit   |   1   |  0  |   Y  |  N  | b'0' |    是否打开新标签页    |
|  27 |    new\_windowUrl   |  varchar |  200  |  0  |   Y  |  N  |      |     新标签页地址     |

**表名：** T\_SERVICE\_TYPE

**说明：** 服务类型表

**数据列：**

|  序号 |       名称       |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明   |
| :-: | :------------: | :------: | :-: | :-: | :--: | :-: | :-: | :----: |
|  1  |       ID       |  bigint  |  20 |  0  |   N  |  Y  |     |  主键ID  |
|  2  |      title     |  varchar |  64 |  0  |   Y  |  N  |     |  邮件标题  |
|  3  | english\_title |  varchar |  64 |  0  |   Y  |  N  |     | 英文邮件标题 |
|  4  |  created\_user |  varchar |  64 |  0  |   Y  |  N  |     |   创建者  |
|  5  |  created\_time | datetime |  19 |  0  |   Y  |  N  |     |  创建时间  |
|  6  |  updated\_user |  varchar |  64 |  0  |   Y  |  N  |     |   修改者  |
|  7  |  updated\_time | datetime |  19 |  0  |   Y  |  N  |     |  修改时间  |
|  8  |     deleted    |    bit   |  1  |  0  |   Y  |  N  |     |  是否删除  |
|  9  |     weight     |    int   |  10 |  0  |   Y  |  N  |     |   权值   |

**表名：** T\_USER

**说明：** 用户表

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |     说明     |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :----------------: | :--------: |
|  1  |   USER\_ID   |  varchar |  64 |  0  |   N  |  Y  |                    |    用户ID    |
|  2  |     NAME     |  varchar |  64 |  0  |   N  |  N  |                    |     名称     |
|  3  |    BG\_ID    |    int   |  10 |  0  |   N  |  N  |                    |    事业群ID   |
|  4  |   BG\_NAME   |  varchar | 256 |  0  |   N  |  N  |                    |    事业群名称   |
|  5  |   DEPT\_ID   |    int   |  10 |  0  |   Y  |  N  |                    | 项目所属二级机构ID |
|  6  |  DEPT\_NAME  |  varchar | 256 |  0  |   Y  |  N  |                    | 项目所属二级机构名称 |
|  7  |  CENTER\_ID  |    int   |  10 |  0  |   Y  |  N  |                    |    中心ID    |
|  8  | CENTER\_NAME |  varchar | 256 |  0  |   Y  |  N  |                    |    中心名字    |
|  9  |   GROYP\_ID  |    int   |  10 |  0  |   Y  |  N  |                    |    用户组ID   |
|  10 |  GROUP\_NAME |  varchar | 256 |  0  |   Y  |  N  |                    |    用户组名称   |
|  11 | CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |                    |    创建时间    |
|  12 | UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |    更新时间    |

**表名：** T\_USER\_DAILY\_FIRST\_AND\_LAST\_LOGIN

**说明：**

**数据列：**

|  序号 |         名称         |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明   |
| :-: | :----------------: | :------: | :-: | :-: | :--: | :-: | :-: | :----: |
|  1  |         ID         |  bigint  |  20 |  0  |   N  |  Y  |     |  主键ID  |
|  2  |      USER\_ID      |  varchar |  64 |  0  |   N  |  N  |     |  用户ID  |
|  3  |        DATE        |   date   |  10 |  0  |   N  |  N  |     |   日期   |
|  4  | FIRST\_LOGIN\_TIME | datetime |  19 |  0  |   N  |  N  |     | 首次登录时间 |
|  5  |  LAST\_LOGIN\_TIME | datetime |  19 |  0  |   N  |  N  |     | 最近登录时间 |

**表名：** T\_USER\_DAILY\_LOGIN

**说明：**

**数据列：**

|  序号 |      名称     |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |  说明  |
| :-: | :---------: | :------: | :-: | :-: | :--: | :-: | :-: | :--: |
|  1  |      ID     |  bigint  |  20 |  0  |   N  |  Y  |     | 主键ID |
|  2  |   USER\_ID  |  varchar |  64 |  0  |   N  |  N  |     | 用户ID |
|  3  |     DATE    |   date   |  10 |  0  |   N  |  N  |     |  日期  |
|  4  | LOGIN\_TIME | datetime |  19 |  0  |   N  |  N  |     | 登录时间 |
|  5  |      OS     |  varchar |  32 |  0  |   N  |  N  |     | 操作系统 |
|  6  |      IP     |  varchar |  32 |  0  |   N  |  N  |     | ip地址 |
