# devops\_ci\_plugin

**数据库名：** devops\_ci\_plugin

**文档版本：** 1.0.0

**文档描述：** devops\_ci\_plugin的数据库文档

|                       表名                       |  说明 |
| :--------------------------------------------: | :-: |
|      [T\_PLUGIN\_CODECC](broken-reference)     |     |
| [T\_PLUGIN\_CODECC\_ELEMENT](broken-reference) |     |
|  [T\_PLUGIN\_GITHUB\_CHECK](broken-reference)  |     |
|    [T\_PLUGIN\_GIT\_CHECK](broken-reference)   |     |

**表名：** T\_PLUGIN\_CODECC

**说明：**

**数据列：**

|  序号 |          名称          |   数据类型   |     长度     | 小数位 | 允许空值 |  主键 | 默认值 |   说明  |
| :-: | :------------------: | :------: | :--------: | :-: | :--: | :-: | :-: | :---: |
|  1  |          ID          |  bigint  |     20     |  0  |   N  |  Y  |     |  主键ID |
|  2  |      PROJECT\_ID     |  varchar |     64     |  0  |   Y  |  N  |     |  项目ID |
|  3  |     PIPELINE\_ID     |  varchar |     34     |  0  |   Y  |  N  |     | 流水线ID |
|  4  |       BUILD\_ID      |  varchar |     34     |  0  |   Y  |  N  |     |  构建ID |
|  5  |       TASK\_ID       |  varchar |     34     |  0  |   Y  |  N  |     |  任务ID |
|  6  | TOOL\_SNAPSHOT\_LIST | longtext | 2147483647 |  0  |   Y  |  N  |     |       |

**表名：** T\_PLUGIN\_CODECC\_ELEMENT

**说明：**

**数据列：**

|  序号 |        名称        |   数据类型   |     长度     | 小数位 | 允许空值 |  主键 | 默认值 |                    说明                   |
| :-: | :--------------: | :------: | :--------: | :-: | :--: | :-: | :-: | :-------------------------------------: |
|  1  |        ID        |  bigint  |     20     |  0  |   N  |  Y  |     |                   主键ID                  |
|  2  |    PROJECT\_ID   |  varchar |     128    |  0  |   Y  |  N  |     |                   项目ID                  |
|  3  |   PIPELINE\_ID   |  varchar |     34     |  0  |   Y  |  N  |     |                  流水线ID                  |
|  4  |    TASK\_NAME    |  varchar |     256    |  0  |   Y  |  N  |     |                   任务名称                  |
|  5  |  TASK\_CN\_NAME  |  varchar |     256    |  0  |   Y  |  N  |     |                  任务中文名称                 |
|  6  |     TASK\_ID     |  varchar |     128    |  0  |   Y  |  N  |     |                   任务ID                  |
|  7  |     IS\_SYNC     |  varchar |      6     |  0  |   Y  |  N  |     |                  是否是同步                  |
|  8  |    SCAN\_TYPE    |  varchar |      6     |  0  |   Y  |  N  |     |             扫描类型（0：全量,1：增量）             |
|  9  |     LANGUAGE     |  varchar |    1024    |  0  |   Y  |  N  |     |                   工程语言                  |
|  10 |     PLATFORM     |  varchar |     16     |  0  |   Y  |  N  |     |   codecc原子执行环境，例如WINDOWS，LINUX，MACOS等   |
|  11 |       TOOLS      |  varchar |    1024    |  0  |   Y  |  N  |     |                   扫描工具                  |
|  12 |    PY\_VERSION   |  varchar |     16     |  0  |   Y  |  N  |     | 其中“py2”表示使用python2版本，“py3”表示使用python3版本 |
|  13 |    ESLINT\_RC    |  varchar |     16     |  0  |   Y  |  N  |     |                  js项目框架                 |
|  14 |    CODE\_PATH    | longtext | 2147483647 |  0  |   Y  |  N  |     |                  代码存放路径                 |
|  15 |   SCRIPT\_TYPE   |  varchar |     16     |  0  |   Y  |  N  |     |                   脚本类型                  |
|  16 |      SCRIPT      | longtext | 2147483647 |  0  |   Y  |  N  |     |                   打包脚本                  |
|  17 |   CHANNEL\_CODE  |  varchar |     16     |  0  |   Y  |  N  |     |                渠道号，默认为DS                |
|  18 | UPDATE\_USER\_ID |  varchar |     128    |  0  |   Y  |  N  |     |                 更新的用户id                 |
|  19 |    IS\_DELETE    |  varchar |      6     |  0  |   Y  |  N  |     |                是否删除0可用1删除               |
|  20 |   UPDATE\_TIME   | datetime |     19     |  0  |   Y  |  N  |     |                   更新时间                  |

**表名：** T\_PLUGIN\_GITHUB\_CHECK

**说明：**

**数据列：**

|  序号 |        名称        |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明   |
| :-: | :--------------: | :------: | :-: | :-: | :--: | :-: | :-: | :----: |
|  1  |        ID        |  bigint  |  20 |  0  |   N  |  Y  |     |  主键ID  |
|  2  |   PIPELINE\_ID   |  varchar |  64 |  0  |   N  |  N  |     |  流水线ID |
|  3  |   BUILD\_NUMBER  |    int   |  10 |  0  |   N  |  N  |     |  构建编号  |
|  4  |     REPO\_ID     |  varchar |  64 |  0  |   Y  |  N  |     |  代码库ID |
|  5  |    COMMIT\_ID    |  varchar |  64 |  0  |   N  |  N  |     | 代码提交ID |
|  6  |  CHECK\_RUN\_ID  |  bigint  |  20 |  0  |   N  |  N  |     |        |
|  7  |   CREATE\_TIME   | datetime |  19 |  0  |   N  |  N  |     |  创建时间  |
|  8  |   UPDATE\_TIME   | datetime |  19 |  0  |   N  |  N  |     |  更新时间  |
|  9  |    REPO\_NAME    |  varchar | 128 |  0  |   Y  |  N  |     |  代码库别名 |
|  10 | CHECK\_RUN\_NAME |  varchar |  64 |  0  |   Y  |  N  |     |        |

**表名：** T\_PLUGIN\_GIT\_CHECK

**说明：**

**数据列：**

|  序号 |       名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明   |
| :-: | :-----------: | :------: | :-: | :-: | :--: | :-: | :-: | :----: |
|  1  |       ID      |  bigint  |  20 |  0  |   N  |  Y  |     |  主键ID  |
|  2  |  PIPELINE\_ID |  varchar |  64 |  0  |   N  |  N  |     |  流水线ID |
|  3  | BUILD\_NUMBER |    int   |  10 |  0  |   N  |  N  |     |  构建编号  |
|  4  |    REPO\_ID   |  varchar |  64 |  0  |   Y  |  N  |     |  代码库ID |
|  5  |   COMMIT\_ID  |  varchar |  64 |  0  |   N  |  N  |     | 代码提交ID |
|  6  |  CREATE\_TIME | datetime |  19 |  0  |   N  |  N  |     |  创建时间  |
|  7  |  UPDATE\_TIME | datetime |  19 |  0  |   N  |  N  |     |  更新时间  |
|  8  |   REPO\_NAME  |  varchar | 128 |  0  |   Y  |  N  |     |  代码库别名 |
|  9  |    CONTEXT    |  varchar | 255 |  0  |   Y  |  N  |     |   内容   |
