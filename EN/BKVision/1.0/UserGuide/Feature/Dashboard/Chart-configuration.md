## Chart Configuration

As the core page of the chart platform, its design and functionality are crucial to the user experience and efficiency of chart generation. The following is a further explanation of the chart configuration page:

### Mode selection

Chart configuration is divided into two modes, namely "self-service mode" and "SQL mode". The data, style and display box of the two modes are the same, only the query method is different. The query in the self-service mode requires the user to select indicators and dimensions for setting, while the query in the SQL mode is queried through SQL statement output;

- **Self-service mode**

![Chart-configuration](../media/Chart-configuration.png)

- **SQL mode**

![SQL-Mode](../media/SQL-Mode.png)

### Layout

It is divided into data, style, query and preview. Users can choose the layout according to specific needs. The query and preview cannot be hidden;![table-layout](../media/table-layout.png)

### Data

​ **`Data source`**: Find the data source for configuring the chart

​ **`Data set`**: Find the data set for configuring the chart

**`Field display`**:Based on the selected dataset, display the field name and display name of the dataset

​ **`Virtual field`**: A field that does not actually store data in the database, but is obtained by calculating or converting the data of existing fields. It can be created based on the values, functions, and expressions of other fields; click on the virtual field, and the page will jump to the new virtual field page;

​ **`One-click picture matching`**: Help users automatically match the appropriate chart according to the dataset
### Query

- **Self-service mode**: Select the indicators and dimensions to be configured for the chart from the field display of the data on the left; advanced settings also include filtering, sorting, limiting and filtering items;

​ **Indicators**: Click the indicator setting button to display the "Field Settings" page, where the field name cannot be modified, the display name can be modified, the aggregation algorithm includes count, deduplication count and non-aggregation, and the field notes help users understand the meaning of the field by entering information;

![zhibiao-shezhi](../media/zhibiao-shezhi.png)

​ **Dimensions**: Click the dimension setting button to display the "Field Settings" page, where the field name cannot be modified, the display name can be modified, the value is translated into a selection dictionary table, and the field notes help users understand the meaning of the field by entering information;

![weidu-shezhi](../media/weidu-shezhi.png)

​ **Advanced settings**:

​ **Filter**: Allow users to filter data based on specific conditions or attributes. For example, users can choose to display only records with sales greater than a certain value, or only display sales data for a specific region;

![filter](../media/filter.png)

​ **Sort**: Allows users to sort by the selected field. Users can choose ascending (small to large) or descending (large to small) sorting;

![order](../media/order.png)

​ **Limit**: Allows users to limit the amount of data displayed;

![high-level](../media/high-level.png)

​ **Filter**: Not yet available

​ **Preview Query SQL**: Displays the SQL statement corresponding to the query module;

![SQLview](../media/SQLview.png)

- **SQL Mode**: Enter SQL statements, three-step query;

**Query Tip**: Query Tip is an auxiliary function that provides real-time suggestions and feedback when users write SQL queries. These tips can help users avoid syntax errors and optimize query performance;

![select-notice](../media/select-notice.png)

**Query Details**: The query details page shows the progress of the SQL query constructed by the user. This includes submitting queries, connecting to storage, executing queries, and rendering data;

![sql2](../media/sql2.png)

**Query results**: Displays the results of SQL query execution; this includes the queried indicators, dimensions, and charts;

![sql3](../media/sql3.png)

### Display box

Based on the **`Query`** operation, you can intuitively view the configured chart in the display box, which is convenient for timely adjustment and change of configuration

### Style

Different types of components have different style settings. The following will divide the components into charts, interactive components, and layout components for explanation:

#### 1. Chart

It is divided into **`Basic configuration`** and **`Advanced configuration`**. Users can customize the style according to their needs to meet different scenarios. Of course, in addition to general configurations such as: title, indicator value processing, etc., different configurations are provided for different charts;

**Basic configuration**:

**General**:

- **Title/Remark**: briefly summarizes the theme or content of the chart; the title/remark can be displayed;

​ Title and subtitle: the font color can be modified;

​ Remark: help users better understand the meaning of the chart;

​ Display position: the position of the title, divided into left alignment, center alignment and right alignment;

<img src="../media/title.png" alt="title" style="zoom:33%;" />

- **Indicator value processing**: that is, "unit conversion", to prevent the length of a single data in the chart from being too long and affecting observability; you can choose not to convert; support multiple indicator value display rules;

​ Conversion information: according to the conversion rules, retain decimal places, source data value units and target units are converted into appropriate target numerical units;

<img src="../media/change.png" alt="change" style="zoom:33%;" />

- **Prompt window**: When the user hovers or clicks on the chart element, the information of the indicator or dimension at that position is displayed; you can choose to close the prompt window;

​ Multi-dimensional sorting method: Select the information display method in the prompt window, which is divided into no processing, positive order and reverse order;

<img src="../media/notice.png" alt="notice" style="zoom:33%;" />

- **Legend**: The legend explains the meaning of the dimensions referred to by different colors in the chart; you can choose to close the legend;

​Legend position: Determine the position of the legend, such as below and to the right, to avoid blocking the data;

<img src="../media/tuli.png" alt="tuli" style="zoom:33%;" />

- **Coordinate axis**: "X axis" and "Y axis"; adjust the coordinate axis scale spacing and text angle;

​ X axis: Enter title; display value; can adjust the text angle of X axis;

​ Y axis: Enter title; display grid lines; the number of scales of Y axis can be automatically calculated or manually fixed; display value;

<img src="../media/xy.png" alt="xy" style="zoom:33%;" />

- **Background**: Support users to adjust the color of the chart background and upload background images;

<img src="../media/background.png" alt="background" style="zoom:33%;" />

- **Border**: Adjust the design of the chart border;

<img src="../media/biankuang.png" alt="biankuang" style="zoom:33%;" />

**Special**: Different types of **graphics** have different settings;

- **Line chart**

​ Style: Select three different styles of line charts;

​ Display value permanently: Whether to display each data point on the chart;

​ Identify maximum/minimum value: Identify the maximum and minimum values ​​of each line chart;

​ Data point size: The circle size range of each data point. The larger the data point, the more obvious it is;

​ Area filling: Fill the area of ​​the line with color from the x-axis;

​ Display sum: Display the sum of the ordinate values ​​corresponding to the abscissa;

​ Line width: The thickness of the corresponding line chart;

​ Null value processing: According to the particularity of the line chart, there may be a y value corresponding to a certain x-axis that is a null value. Two processing methods are supported, namely, no processing and connecting the points with values ​​before and after;

<img src="../media/picture.png" alt="picture" style="zoom:33%;" />

- **Bar chart**

​ Display of value permanently: whether to display each data point on the chart;

​ Position: the position of the value mark in the column, which is divided into the inside of the column, the top of the column and the right side of the column;

​ Mark the maximum/minimum value: mark the maximum and minimum values ​​of all columns;

​ Column transparency: drag to display the transparency of the column and display the transparency value on the right;

<img src="../media/zhuzhuangtu.png" alt="zhuzhuangtu" style="zoom:33%;" />

- **Pie chart**

​ Display of value permanently: whether to display each data point on the chart;

​ Label alignment: the position of the label displayed in each part, which is divided into irregular, edge-aligned and text-stacked;

​ Pie size: the size of the outer circle of the pie chart;

​ Inner circle size: the size of the hollow circle centered on the center of the circle, which makes the basic pie chart become a ring chart;

​Rounded corners of donut chart: round the edges of donut chart to give it a rounded appearance;

​ Display quantity limit: too many types of pie chart data will cause stacking to fail to determine key information. You can limit the quantity limit to maintain the beauty of the chart;

<img src="../media/bingtu.png" alt="bingtu" style="zoom:33%;" />

- **Digital panel**

​ Display indicator name: the name of the data indicator displayed on the digital panel;

​ Font size; font color;

​ Multi-indicator spacing: the horizontal distance between multiple indicators on the digital panel to improve the clarity of the overall layout;

​ Multi-indicator arrangement: the layout of multiple indicators, divided into paging and tiling;

​ Display quantity per row: the number of indicators displayed per row;

<img src="../media/shuzimianban.png" alt="shuzimianban" style="zoom:33%;" />

- **Details table**

​Style: The overall style of the detail table, divided into a unified background color of white and zebra stripes;

​ Row height: The height of each row of data, custom numerical adjustment;

​ Column width: The width of each column of data, divided into default and custom;

​ Column order: The arrangement order of each column, each custom adjustment order;

​ Column freeze: When scrolling the detail table, the function of keeping certain columns always visible can lock columns from left to right or from right to left;

​ Column alignment: The horizontal alignment of each column of data in the detail table, divided into left alignment, center alignment and right alignment;

​ Function switch: Provides some optional functions, such as search box, column filter and column sorting;

​ Paging: The function of dividing into multiple parts for display, which can be paging and set the number of data displayed per page;

​ Lines: Lines used to separate rows and columns, supporting row separators, column separators and outer borders;

<img src="../media/mingxibiao.png" alt="mingxibiao" style="zoom:33%;" />

**Advanced configuration**: only some charts support it;

- **Summary statistics**: **Bar chart** and **Pie chart** support it; that is, according to the selected different indicators, the maximum value, minimum value, average value, total value and latest value are counted respectively, and displayed in a table at the bottom of the chart in the display box, so that users can see the special values ​​of the chart at a glance;

![highlevel](../media/highlevel.png)

- **Deformation**: **Digital panel** and **Digital & trend line** support it;

​ Indicator: Select the configured indicator that needs to be deformed; multiple indicator deformations are supported;

​ Selection conditions: that is, the conditions that need to be deformed, which are divided into value, range and regularity;

​ Deformed value: You can use the variable {{value}}l to read the original value. For example, if the original value is 9999, fill in the deformed value: "Danger!{{value}}", and the final rendering result is: "Danger!9999";

​ Font change: Change the color of the indicator value and the deformed value;

​Additional logo: When the selection conditions are met and the additional logo is checked, the following effects will appear on the chart, supporting three logos and changing colors;

<img src="../media/bianxing.png" alt="bianxing" style="zoom:33%;" />

- **Auxiliary trend line**: only **numbers & trend lines**;

​ Whether to compare values: whether to compare data points, and the trend and percentage will be displayed in the chart;

​ Comparison point interval: custom interval;

​ Comparison mark: custom red up and green down and green up and red down;

​ Remark suffix: briefly explain the content;

​ Whether to show trends: the starting value of the Y axis can be customized;

<img src="../media/fuzhuqushixian.png" alt="fuzhuqushixian" style="zoom:33%;" />

- **Annotation**: only **map**;

​ Field: select the configured indicator field;

​Selection conditions: the specific conditions that need to be marked;

​ Marking icons: Marking at the corresponding position on the map if the selection conditions are met, and custom icons are supported;

​ Marking color: the color of the icon;

​ Prompt information: hover the mouse over the position marked by the icon to display the prompt window and prompt information;

<img src="../media/map.png" alt="map" style="zoom:33%;" />

#### 2. Interactive components

Interactive components and layout components do not have a chart configuration page, that is, the right edit bar pops up for direct editing;

**Time range selector**: filter data by selecting a time range to achieve the demand of viewing data graphics of different time ranges;

​ **Basic information**:

​ Component identifier: the character used to uniquely identify the component, only `a-z 0-9 _` is supported;

​ Component title: the text displayed on the dashboard, concisely matching functions and content;

​ Component description: a detailed description of the component function for easy understanding;

​Title style: Two styles are available: top-bottom structure and left-right structure;

​ Select scope: Select the specific chart information for the time range filter, including data source, data set and corresponding time field;

​ Default value: The time range for the chart data display;

<img src="../media/time.png" alt="time" style="zoom:33%;" />

**Drop-down selector**: Configure different drop-down option values ​​to provide users with options to filter the data returned by the chart;

​ Basic information: Same as the time range selector;

​ Filter data: Support filtering multiple data; Manually enter data source, data set and field; Support multiple selection, support providing all options;

​ Select scope: Select the specific chart information for the drop-down selector, including data source, data set and corresponding field;

![xialaxuanzeqi](../media/xialaxuanzeqi.png)

**Selection box**: Provides different options for users to select to filter the data returned by the chart; provides two style options based on the function of the drop-down selector;

![choice](../media/choice.png)

#### 3. Layout components

**Grouping**: Group similar charts into a group for easy moving and editing or viewing;

![fenzu](../media/fenzu.png)

**Placeholder**: Blank placeholder for beautiful layout;

![zhanweige](../media/zhanweige.png)

**Tab container**: Applicable to scenarios where different contents need to be displayed in the same area by switching tabs; for example: the "electrical appliances" classification area of ​​e-commerce, each Tab is a type of electrical appliance, such as TV, washing machine, air conditioner, etc.; each time a Tab is switched, any component can be dragged and embedded in the container; supports four different style settings;

![Tab](../media/Tab.png)
