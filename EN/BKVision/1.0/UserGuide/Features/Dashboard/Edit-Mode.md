## Edit Mode

After entering the edit mode, users can freely select "components", "themes", "layouts", "linkages", etc. to configure the dashboard globally;

![Edit-Mode](../media/Edit-Mode.png)

- **Component/Theme/Layout Settings**

1. **Component**

​ **Content**: Currently supports 27 components. For component types and function descriptions, please refer to [Component Classification and Function Description](Chart-Classification-and-Function-Description.md);

​ **Blank Chart Component**: The chart platform supports **`Blank Chart Component`**, which is suitable for scenarios where data objects and query logic have been clarified but what graphics to use are still uncertain;

​ **Position**: Supports component dragging function. Click any component and drag it to the canvas, or a gray box will appear on the top of the component when the mouse hovers. Click the gray box to drag the component to move the position;

​ **Size**: Supports dragging the lower right corner of the blue border of the chart to adjust the size of the component;

​**Single chart editing**: hover the top of the chart, **`Edit chart`**, **`Delete chart`**, **`Full screen display`**, **`Refresh`**, **`Copy to clipboard`**, **`Export Excel`**, **`View SQL`** and other functions can be displayed in the upper right corner to edit a single chart;

2. **Theme**

Change the overall dashboard color and style to meet various scene applications. Currently supports 6 themes: bright, calm, dreamy, fresh, colorful and retro;

![theme](../media/theme.png)

3. **Layout**

Provide 4 optional layout modes, namely **`Single column`**, **`Double column`**, **`Three columns`** and **`Four columns`**, simplify page layout and typesetting, no need to manually adjust the chart border size;

![layout](../media/layout.png)

- **Global function settings**

​ **Preview**: Supports full-screen display of the dashboard. You can click refresh in the upper right corner and set the refresh time;

![view](../media/view.png)

​ **Linkage**: An interactive function for data visualization, which allows users to view a data view and the selection or operation they make can affect other related data views in real time; for specific information on how to set linkage, please refer to [How to query data linkage between different charts? ](/UserGuide/Best-Practices/Creat-Link.md);

![table-link](../media/table-link.png)

​ **Variable**: constant, which will not be displayed in the dashboard. It is only used as a parameter configuration for data query logic. It only works when the dashboard is rendered and cannot be interactive or dynamically changed. "Constants" are generally applicable to global parameter setting scenarios of charts, such as project ID, business ID, etc.

![variable](../media/variable.png)

​ **`Variable name`**: Name the variable to facilitate direct query in SQL statements

​ **`Variable value`**: Select the value corresponding to the variable name

​ **`Description`**: Note the purpose and precautions of the variable

​ **History, help** are not yet available