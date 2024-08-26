## 组件分类及功能描述

表格中是BKVision现有组件的类型、名称及功能描述，用户可通过图表功能描述选择合适的组件类型：

<table border="1">
    <tr> 
        <th class="center-text" style="width: 100px;">类型</th>
        <th style="width: 150px;" class="center-text">图形</th>
        <th class="center-text">功能描述</th>
    </tr>
    <tr>
        <td class="center-text" style="width: 100px;" rowspan="7">柱线图</td>
        <td style="width: 150px;">折线图</td>
        <td>适用于展示维度值比较“有序”的数据，如时间序列。</td>
    </tr>
    <tr>
        <td style="width: 150px;">堆叠面积图</td>
        <td>适用于需要查看各个X点不同维度值聚合的趋势场景。</td>
    </tr>
    <tr>
        <td style="width: 150px;">基础柱状图</td>
        <td>适用于展示不同维度的指标数值横向对比，如：多个城市(维度)的玩家人数(指标)分布对比。</td>
    </tr>
    <tr>
        <td style="width: 150px;">堆叠柱状图</td>
        <td>适用于展示不同维度和子维度的数值大小对比，如：不同省份数据对比，每个省份柱子内同时展示各个城市的数值。</td>
    </tr>
    <tr>
        <td style="width: 150px;">基础条形图</td>
        <td>条形图和基础柱状图的差异只是一个是水平展示、一个是垂直展示。</td>
    </tr>
    <tr>
        <td style="width: 150px;">堆叠条形图</td>
        <td>适用于展示不同维度和子维度的数值大小对比，如：不同省份数据对比，每个省份柱子内同时展示各个城市的数值。</td>
    </tr>
    <tr>
        <td style="width: 150px;">柱线图</td>
        <td>适用于不同指标需要在同一个有序的时间线上同时展示，便于观察数值差异或变化趋势。</td>
    </tr>
    <tr>
        <td class="center-text" style="width: 100px;" rowspan="4">饼图</td>
        <td style="width: 150px;">普通饼图</td>
        <td>适用于展示不同类别数据在总体构成中的占比，如：不同操作系统类型的使用次数数据。</td>
    </tr>
    <tr>
        <td style="width: 150px;">环形饼图</td>
        <td>环形图只是不同形状的饼图，适用场景是一样的。</td>
    </tr>
    <tr>
        <td style="width: 150px;">玫瑰饼图</td>
        <td>环形图只是不同形状的饼图，适用场景是一样的。</td>
    </tr>
    <tr>
        <td style="width: 150px;">旭日图</td>
        <td>适用于展示有层级关系的多维数据分布情况。例如，公司组架构的“部门-中心-小组”人数统计。</td>
    </tr>
    <tr>
        <td class="center-text" style="width: 100px;">表格</td>
        <td style="width: 150px;">明细表</td>
        <td>适用于平铺展示每一条数据记录的场景，是一种较普遍和通用的数据呈现方式。</td>
    </tr>
    <tr>
        <td class="center-text" style="width: 100px;" rowspan="3">仪表盘</td>
        <td style="width: 150px;">数字面板</td>
        <td>适用于对某个/些具体指标的总览数据展示。</td>
    </tr>
    <tr>
        <td style="width: 150px;">数字&趋势线</td>
        <td>适用于关注具体目标值，以及近期趋势的场景。</td>
    </tr>
    <tr>
        <td style="width: 150px;">仪表盘</td>
        <td>适用于关注具体目标值，以及近期趋势的场景。</td>
    </tr>
    <tr>
        <td class="center-text" style="width: 100px;" rowspan="1">热力图</td>
        <td style="width: 150px;">日历热力图</td>
        <td>适用于需要按月份观察不同日期的数据对比整体情况。</td>
    </tr>
    <tr>
        <td class="center-text" style="width: 100px;" rowspan="1">地图</td>
        <td style="width: 150px;">国家地图</td>
        <td>用颜色的深浅来展示区域范围的数值大小，适合展现呈面状但属分散分布的数据，比如人口密度。</td>
    </tr>
    <tr>
        <td class="center-text" style="width: 100px;" rowspan="2">多媒体</td>
        <td style="width: 150px;">文本框</td>
        <td>适用于需要在仪表盘中插入自定义文本内容，支持引用变量来动态获取数据。</td>
    </tr>
    <tr>
        <td style="width: 150px;">图片</td>
        <td>适用于需要在仪表盘中插入图片，支持本地上传或url地址获取图片。</td>
    </tr>
    <tr>
        <td class="center-text" style="width: 100px;" rowspan="6">交互组件</td>
        <td style="width: 150px;">时间范围选择器</td>
        <td>适用于对图表传入时间范围数值进行数据过滤，以达到查看不同时间区间数据的诉求。</td>
    </tr>
    <tr>
        <td style="width: 150px;">日期时间选择器</td>
        <td>适用于对图表传入特定日期时间进行数据过滤，以达到查看不同时间点数据的诉求。</td>
    </tr>
    <tr>
        <td style="width: 150px;">下拉选择器</td>
        <td>适用于对图表传入时间字段数值进行数据过滤，以达到查看不同时间点/范围数据的诉求。</td>
    </tr>
    <tr>
        <td style="width: 150px;">输入框</td>
        <td>适用于通过输入文本内容来对图表返回的数据进行筛选/过滤。</td>
    </tr>
    <tr>
        <td style="width: 150px;">选择框</td>
        <td>通过配置不同的选项，提供用户勾选以筛选图表返回的数据。</td>
    </tr>
    <tr>
        <td style="width: 150px;">Tab容器</td>
        <td>适用于需要在同一片区域内，通过切换Tab来显示不同内容的场景；例如：电商的”电器“分类区，每一个Tab页对应一种电器类型，如电视、洗衣机、空调，等等...</td>
    </tr>
    <tr>
        <td class="center-text" style="width: 100px;" rowspan="2">布局组件</td>
        <td style="width: 150px;">分组</td>
        <td>适用于将同类图表划分到一个分组，便于一同移动编辑或查看。</td>
    </tr>
    <tr>
        <td style="width: 150px;">占位格</td>
        <td>只是一个空白的占位块，用于布局排版美观所需。</td>
    </tr>
    <tr>
        <td class="center-text" style="width: 100px;" rowspan="2">其他</td>
        <td style="width: 150px;">雷达图</td>
        <td>适用于展示不同对象在同一组指标下的属性对比。</td>
    </tr>
    <tr>
        <td style="width: 150px;">词云图</td>
        <td>适用于对文本数据中的词语出现频次进行统计和可视化的展示场景。</td>
    </tr>
</table>

