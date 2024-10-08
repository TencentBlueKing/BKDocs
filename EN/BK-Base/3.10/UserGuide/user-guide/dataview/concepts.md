## Introduction
Superset is a lightweight BI tool open sourced by Airbnb. By using Superset, users can create various interactive and intuitive charts (Charts) based on the data in the platform's result tables, and use this to build charts that suit each project. Dashboard for analysis and operational needs

## scenes to be used
The platform integration Superset is mainly to meet the needs of users to build **data views** and **simple analysis** when using data.

## Introduction to main concepts
* **Dataset**: refers to the result table generated by the platform and **supports query**. The current result table will be automatically synchronized to the Superset system within one minute after it is generated. The data sets available to users are related to those available in the platform. The queried data set is the same
* **Charts**: refers to content built based on a certain platform data set and used for **visualization and analysis**. Currently, 36 types of charts are supported including line charts, tables, column charts, pie charts, etc. Type, the chart inherits the permissions of the dataset by default
* **Dashboard**: refers to a visual panel that conforms to a specific theme. It is generally constructed from charts that conform to this theme, as well as elements such as filters, tabs, and dividing lines. Users can modify the contents of the dashboard based on specified rules. For **arrangement and layout**, the dashboard uses the permissions of the project by default. Users can also make the dashboard they built public or grant viewing permissions to others.

## Main page introduction
The entrance to Superset is as shown in the figure

![](superset.assets/superset_entrance.png)


### Welcome page
The welcome page of Superset displays the dashboard for users with **authority** by default. Users can switch the tab `Recently Viewed` to view recently visited dashboards or charts. `Recently Viewed` is mainly to help users quickly view frequently accessed content or quickly access recently edited content. Users can also switch the tab `Favorites` to view charts or dashboards that they focus on.

![](superset.assets/superset_welcome_page.png)

### My Dashboard
The management page of the dashboard lists the list of dashboards for which the user **has permission** by default. Users can create new dashboards on this page, or **edit**, **delete**, **view**, **modify meta information** and **authorize* existing dashboards * and other operations. Users with many dashboards can also use the **Filter function** in the upper right corner to filter the dashboards that need to be operated. The filter conditions currently support `dashboard title` and `project`

![](superset.assets/superset_dashboard_page.png)

### My chart
The chart management page lists user-created charts by default. Users can create new charts on this page, or perform **edit**, **delete**, **view**, **modify meta information** and other operations on previously created charts. Users can filter the charts that need to be operated through the **Filter function** in the upper right corner. The filter conditions currently support `chart name`, `description`, `project`, `chart type` and `result table ID`

![](superset.assets/superset_chart_page.png)