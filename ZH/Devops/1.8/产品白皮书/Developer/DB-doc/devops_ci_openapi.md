# devops\_ci\_openapi

**数据库名：** devops\_ci\_openapi

**文档版本：** 1.0.0

**文档描述：** devops\_ci\_openapi的数据库文档

|                     表名                    |        说明        |
| :---------------------------------------: | :--------------: |
|  [T\_APP\_CODE\_GROUP](broken-reference)  | app\_code对应的组织架构 |
| [T\_APP\_CODE\_PROJECT](broken-reference) | app\_code对应的蓝盾项目 |
|   [T\_APP\_USER\_INFO](broken-reference)  |  app\_code对应的管理员 |

**表名：** T\_APP\_CODE\_GROUP

**说明：** app\_code对应的组织架构

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |     说明     |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :--------: |
|  1  |      ID      |  bigint  |  20 |  0  |   N  |  Y  |     |    主键ID    |
|  2  |   APP\_CODE  |  varchar | 255 |  0  |   N  |  N  |     |    APP编码   |
|  3  |    BG\_ID    |    int   |  10 |  0  |   Y  |  N  |     |    事业群ID   |
|  4  |   BG\_NAME   |  varchar | 255 |  0  |   Y  |  N  |     |    事业群名称   |
|  5  |   DEPT\_ID   |    int   |  10 |  0  |   Y  |  N  |     | 项目所属二级机构ID |
|  6  |  DEPT\_NAME  |  varchar | 255 |  0  |   Y  |  N  |     | 项目所属二级机构名称 |
|  7  |  CENTER\_ID  |    int   |  10 |  0  |   Y  |  N  |     |    中心ID    |
|  8  | CENTER\_NAME |  varchar | 255 |  0  |   Y  |  N  |     |    中心名字    |
|  9  |    CREATOR   |  varchar | 255 |  0  |   Y  |  N  |     |     创建者    |
|  10 | create\_time | datetime |  19 |  0  |   Y  |  N  |     |    创建时间    |
|  11 |    UPDATER   |  varchar | 255 |  0  |   Y  |  N  |     |     跟新人    |
|  12 | UPDATE\_TIME | datetime |  19 |  0  |   Y  |  N  |     |    修改时间    |

**表名：** T\_APP\_CODE\_PROJECT

**说明：** app\_code对应的蓝盾项目

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |   说明  |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :---: |
|  1  |      ID      |  bigint  |  20 |  0  |   N  |  Y  |     |  主键ID |
|  2  |   APP\_CODE  |  varchar | 255 |  0  |   N  |  N  |     | APP编码 |
|  3  |  PROJECT\_ID |  varchar | 255 |  0  |   N  |  N  |     |  项目ID |
|  4  |    CREATOR   |  varchar | 255 |  0  |   Y  |  N  |     |  创建者  |
|  5  | create\_time | datetime |  19 |  0  |   Y  |  N  |     |  创建时间 |

**表名：** T\_APP\_USER\_INFO

**说明：** app\_code对应的管理员

**数据列：**

|  序号 |      名称      |   数据类型   |  长度 | 小数位 | 允许空值 |  主键 | 默认值 |    说明    |
| :-: | :----------: | :------: | :-: | :-: | :--: | :-: | :-: | :------: |
|  1  |      ID      |    int   |  10 |  0  |   N  |  Y  |     |   主键ID   |
|  2  |   APP\_CODE  |  varchar |  64 |  0  |   N  |  N  |     |   APP编码  |
|  3  |  MANAGER\_ID |  varchar |  64 |  0  |   N  |  N  |     | APP管理员ID |
|  4  |  IS\_DELETE  |    bit   |  1  |  0  |   N  |  N  |     |   是否删除   |
|  5  | CREATE\_USER |  varchar |  64 |  0  |   N  |  N  |     |   添加人员   |
|  6  | CREATE\_TIME | datetime |  23 |  0  |   N  |  N  |     |   添加时间   |
