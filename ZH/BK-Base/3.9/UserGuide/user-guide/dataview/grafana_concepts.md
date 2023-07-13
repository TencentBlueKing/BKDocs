## 简介
Grafana 是一个开源的用于 **度量分析** 与 **可视化** 的套件。目前在开源社区中逐渐火热起来，公司内使用 Grafana 的用户也越来越多，因此，IEG 平台也与 Grafana 系统进行了深度对接，使用户能在 Grafana 中直接使用 **平台的结果表** 构建各种满足用户监控、运营、分析场景的仪表板。

## 使用场景
平台集成 Grafana 主要是为了满足用户使用数据时需要构建 **监控仪表板** 和 **运营数据** 等需求

## 主要概念介绍
* **Dashboard** ：指符合某个特定主题的仪表板，一般由 **Row** 和符合这个主题的 **Panel** 组成，用户可以基于指定规则对仪表板的内容进行 **编排和布局**
* **Row** ：行， Dashboard 的基本组成单元，主要作用是 **划分区域** ，一个 Dashboard 可以包含很多个 Row
* **Panel** ：可视化面板，组成 Dashboard 的主要内容，用户可以在面板中使用 **SQL 表单** 或者 **SQL 编辑器** 来构建平台的查询。查询的结果可以用各种可视化的方式进行展示，目前支持的可视化类型有：**线图( Graph )** 、 **数值( Stat )** 、 **柱状图( Bar Gauge )** 、 **表格( Table )** 、 **文本( Text )** 等等
* **Folder** ：文件夹，当 Dashboard 太多，显得杂乱时，可以用 **文件夹** 给 Dashboard 进行分类，方便用户管理 Dashboard
* **Variables** ：仪表板变量，作用于某个 Dashboard 里所有的 Panel ，Panel 在构建 **查询 SQL** 时可以使用变量作为占位符，实际发起查数据请求时会替换成实际的值

## 权限体系介绍
平台集成的 Grafana 主要用平台的项目划分权限，具有某个项目 **项目查看** 权限的用户可以查看项目下所有 Dashboard 的结构和面板，但不包含面板中的数据，只有用户在平台有该结果表的 **数据查询** 权限，才能看到面板中的数据内容。另外，项目下只有 **数据开发成员** 和 **项目管理者** 才有对项目下的 Dashboard 和 Folder 进行编辑并保存的权限

构建 Dashboard 时，如果 `结果表下拉列表` 没有出现期望的表，需要类似《数据开发》以项目的名义申请对应的结果表，详情参考 [数据开发创建项目，项目中怎么看不到数据](../auth-management/data.md#数据开发创建项目，项目中怎么看不到数据)

## 主要页面介绍
Grafana 的入口如图所示
![](grafana.assets/grafana_entrance.png)


### 首页
Grafana 系统的入口页面，用户通过右上角 **切换项目** 下拉框选择项目后进入的页面，左侧默认展示用户收藏的仪表板( Starred dashboards )和最近查看的仪表板( Recently viewed dashboards )。

![](grafana.assets/grafana_home_page.png)

用户点击左上角 **Home** 可以查看当前项目下的所有文件夹( Folder )和仪表板( Dashboard )，下拉框也具备搜索的功能，可以快速找到需要查看的仪表板。

![](grafana.assets/grafana_home_button.png)

如果用户需要新建仪表板或者新建文件夹，可以通过右上角快速跳转到创建页面，也可以在 Home 下拉菜单中点击 **New dashboard** 和 **New folder** 进行跳转

![](grafana.assets/grafana_new_button.png)

### 仪表板管理页面
Dashboards 的管理页面，用户可以在管理页面中对仪表板进行 **查看** 、 **过滤** 、 **分文件夹** 等操作，用户也可以在 **Playlists** 标签下创建 **仪表板播放列表**

![](grafana.assets/grafana_manage_dashboards.png)

### 仪表板创建和编辑页面
点击 **创建仪表板** 后就会进入到一个空的仪表板编辑页面，并且默认创建一个空的 **Panel** ，整个编辑页面可以分为三个区域，分别是 **面板配置和编排区域** 、 **管理工具栏** 和 **时间工具栏** 。

![](grafana.assets/grafana_dashboard_edit.png)
