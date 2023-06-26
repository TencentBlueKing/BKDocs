# devops\_ci\_log

**数据库名：** devops\_ci\_log

**文档版本：** 1.0.0

**文档描述：** devops\_ci\_log的数据库文档

|                    表名                   |      说明      |
| :-------------------------------------: | :----------: |
| [T\_LOG\_INDICES\_V2](broken-reference) | 构建日志已关联ES索引表 |
|    [T\_LOG\_STATUS](broken-reference)   |   构建日志打印状态表  |
|   [T\_LOG\_SUBTAGS](broken-reference)   |   构建日志子标签表   |

**表名：** T\_LOG\_INDICES\_V2

**说明：** 构建日志已关联ES索引表

**数据列：**

|  序号 |         名称         |    数据类型   |  长度 | 小数位 | 允许空值 |  主键 |         默认值        |             说明            |
| :-: | :----------------: | :-------: | :-: | :-: | :--: | :-: | :----------------: | :-----------------------: |
|  1  |         ID         |   bigint  |  20 |  0  |   N  |  Y  |                    |            主键ID           |
|  2  |      BUILD\_ID     |  varchar  |  64 |  0  |   N  |  N  |                    |            构建ID           |
|  3  |     INDEX\_NAME    |  varchar  |  20 |  0  |   N  |  N  |                    |                           |
|  4  |   LAST\_LINE\_NUM  |   bigint  |  20 |  0  |   N  |  N  |          1         |            最后行号           |
|  5  |    CREATED\_TIME   | timestamp |  19 |  0  |   N  |  N  | CURRENT\_TIMESTAMP |            创建时间           |
|  6  |    UPDATED\_TIME   | timestamp |  19 |  0  |   N  |  N  | 2019-11-1100:00:00 |            修改时间           |
|  7  |       ENABLE       |    bit    |  1  |  0  |   N  |  N  |        b'0'        |    buildisenablev2ornot   |
|  8  | LOG\_CLUSTER\_NAME |  varchar  |  64 |  0  |   N  |  N  |                    |   multieslogclustername   |
|  9  |    USE\_CLUSTER    |    bit    |  1  |  0  |   N  |  N  |        b'0'        | usemultieslogclusterornot |

**表名：** T\_LOG\_STATUS

**说明：** 构建日志打印状态表

**数据列：**

|  序号 |       名称       |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 |          默认值          |          说明          |
| :-: | :------------: | :------: | :-: | :-: | :--: | :-: | :-------------------: | :------------------: |
|  1  |       ID       |  bigint  |  20 |  0  |   N  |  Y  |                       |         主键ID         |
|  2  |    BUILD\_ID   |  varchar |  64 |  0  |   N  |  N  |                       |         构建ID         |
|  3  |       TAG      |  varchar |  64 |  0  |   Y  |  N  |                       |          标签          |
|  4  |    SUB\_TAG    |  varchar | 256 |  0  |   Y  |  N  |                       |          子标签         |
|  5  |     JOB\_ID    |  varchar |  64 |  0  |   Y  |  N  |                       |         JOBID        |
|  6  |      MODE      |  varchar |  32 |  0  |   Y  |  N  |                       |    LogStorageMode    |
|  7  | EXECUTE\_COUNT |    int   |  10 |  0  |   N  |  N  |                       |         执行次数         |
|  8  |    FINISHED    |    bit   |  1  |  0  |   N  |  N  |          b'0'         | buildisfinishedornot |
|  9  |  CREATE\_TIME  | datetime |  23 |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |         创建时间         |

**表名：** T\_LOG\_SUBTAGS

**说明：** 构建日志子标签表

**数据列：**

|  序号 |      名称      |   数据类型   |   长度  | 小数位 | 允许空值 |  主键 |          默认值          |   说明  |
| :-: | :----------: | :------: | :---: | :-: | :--: | :-: | :-------------------: | :---: |
|  1  |      ID      |  bigint  |   20  |  0  |   N  |  Y  |                       |  主键ID |
|  2  |   BUILD\_ID  |  varchar |   64  |  0  |   N  |  N  |                       |  构建ID |
|  3  |      TAG     |  varchar |   64  |  0  |   N  |  N  |                       |  插件标签 |
|  4  |   SUB\_TAGS  |   text   | 65535 |  0  |   N  |  N  |                       | 插件子标签 |
|  5  | CREATE\_TIME | datetime |   23  |  0  |   N  |  N  | CURRENT\_TIMESTAMP(3) |  创建时间 |
