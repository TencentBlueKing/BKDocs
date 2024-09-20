## How to quickly build a dashboard

### Dataset preparation
You can refer to the process of [10 Minutes to Play with Big Data Development](../../quick-start/dataflow.md) to create a **queryable** result table

### Create dashboard
You can create a new dashboard through the **New dashboard** and **Create Dashboard** buttons in the **Home** drop-down menu and the **New Dashboard** button on the `Manage Dashboard` page.

![](grafana.assets/grafana_new_dashboard_button1.png)

![](grafana.assets/grafana_new_dashboard_button2.png)

After clicking, it will jump to a blank **Dashboard** page, and a blank **Panel** will be initialized by default.

![](grafana.assets/grafana_new_dashboard_page.png)

### Configure SQL query
Click the **Add Query** button of the above blank **Panel** to enter the **Panel** `Query` configuration page

![](grafana.assets/grafana_panel_config.png)

The project **data source** is selected by default in the configuration page, and the user does not need to modify it. The **data source** has all the permissioned result tables of the project.

![](grafana.assets/grafana_panel_datasource.png)

Select the **result table** and **query data** that need to be used for **display charts** and the **storage** ultimately used. After selection, the form will fill in the **count** of the first field by default. Statistical indicators and basic **WHERE** and **GROUP BY** statements, and use the query results to draw a line graph in **time series** format

![](grafana.assets/grafana_default_panel.png)

Users can edit the SQL form based on the default configuration. For the **SELECT** column, the user can add other indicators that need to be queried, and can modify the **alias (Alias)** of the indicator. Each time the form is modified, a query will be issued by default. to allow users to view charts in real time

![](grafana.assets/grafana_panel_select.png)

For the **WHERE** column, the **time range** in the **time toolbar** in the upper right corner will be used by default to filter the data. The user can continue to add more **filter expressions (Expression)* *, each expression contains three parts: **lvalue**, **operation** and **rvalue**. The lvalue can generally select a field in the result table. The operation currently supports `=`, `!=` , `>` , `>=` , `<` , `<=` , `IN` , `NOT IN` , when clicking the rvalue, the usable data will be pulled from the data in the result table by default Candidate values for users to quickly select rvalues. Users can also manually fill in rvalues.

![](grafana.assets/grafana_panel_where.png)

For the **GROUP BY** column, the line chart will group the time by minutes by default, so that the generated curve will have one point every minute. The user can modify the default **1m** value, if one point per hour is needed , can be changed to **1h**, if one point per day is needed, it can be changed to **1d**, and so on. If the user needs to use dimension fields to **group** the series, they can select the corresponding dimension in the current column. Each **value combination of the dimension** will generate a series for each indicator.

![](grafana.assets/grafana_panel_groupby.png)

If the above form configuration cannot meet the user's needs, the user can click **Modify SQL** to switch to **SQL Editor** mode and manually build SQL

![](grafana.assets/grafana_panel_edit_sql.png)

![](grafana.assets/grafana_panel_sql_editor.png)

Regardless of the mode, if there is an exception in the constructed SQL during query, there will be a specific error message below the form.

![](grafana.assets/grafana_panel_error_tip.png)

For a query result without exception, you can click **Generated SQL** to view the SQL that actually initiated the query.

![](grafana.assets/grafana_panel_generated_sql.png)


### Modify Panel visualization type
After building the SQL, users can generate different charts by modifying the **data format** and **visualization type**. For example: if you want to change the line chart into a table, you can switch the data format to **tabular data* *

![](grafana.assets/grafana_panel_data_format.png)

Then switch to the `Visualization` column (Visualization) and select the Table (Table) type. After selecting, the chart will become a table.

![](grafana.assets/grafana_panel_table.png)

For the title of the table, the user can click the `Add column style` button on the lower side to add the table style and configure the relevant options. The user can also modify the **unit (Unit)** and **alignment (Align)** Wait for legend information

![](grafana.assets/grafana_panel_table_column.png)

### Modify Panel title
Switch to the Genaral column to modify the **Title** and **Description** of the panel.

![](grafana.assets/grafana_panel_general.png)

### Save dashboard
After editing the Panel, remember to save it, otherwise all temporary editing status will be lost. The save button is in the **Management Toolbar** in the upper right corner.

![](grafana.assets/grafana_save_dashboard.png)

When saving, you can name the Dashboard and select the folder (Folder) to be saved.

![](grafana.assets/grafana_save_dashboard_modal.png)

After saving, it will automatically jump back to the global page of Dashboard.

![](grafana.assets/grafana_dashboard_global.png)

### Conclusion

Following the above process, a simple dashboard will be built. It is true that Grafana has many more advanced functions to help users better describe what they want to express. **But remember one thing, our ultimate purpose of using Grafana is not to build a complex, rich, and A powerful dashboard, but we hope to use this tool to help us solve problems in specific business scenarios more intuitively and insightfully**

For more detailed functions, please refer to [Grafana official documentation](https://grafana.com/docs/grafana/latest/panels/panels-overview/)