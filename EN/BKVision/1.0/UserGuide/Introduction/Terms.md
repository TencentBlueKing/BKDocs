# Terminology

This article introduces some terms and basic concepts specific to the Blue Whale Chart Platform.

## Dimension

A descriptive attribute or feature of an object that specifies different values, usually a categorical variable, for example:

- Time dimension: group data by time periods such as days, weeks, and months;

- Geographic dimension: segment data based on the country, region, or city where the user is located;

- User dimension: analyze data based on user attributes such as age, gender, and occupation;

- Product dimension: organize data based on product category, function, or price;

## Time dimension

In some charts that support time trend data types, you can configure the "time" field as the X-axis and set aggregation rules as needed (such as `1 minute` `10 minutes` `1 hour` `1 day`, etc.)

## Indicator

Used to measure the performance of a business or product, usually some numerical variables, such as sales, number of users, conversion rate, etc.;

## Variable

- Component variables: interactive components in the dashboard, "component identifier" is the variable name, including: drop-down selector, selection box, time selector; "component variables" are suitable for dynamic screening and filtering of chart data in the dashboard. When the same batch of charts want to support dynamic selection of condition ranges to display data, use interactive components and configure the associated scope (chart) or reference "component variables" in SQL to meet the requirements;

- Constants: custom variables added in the dashboard, unlike "component variables", "constants" will not be displayed in the dashboard, but only as parameter configurations for data query logic, only work when the dashboard is rendered, and cannot be interactive or dynamically changed; "constants" are generally applicable to global parameter setting scenarios of charts, such as project ID, business ID, etc.;

## "Variable tail"

Variable tail is a unified predefined variable processing function method provided by the platform. Users can use this capability to change the output format or content of the variable;

The usage is just like its name, just append the method name to the end of the variable name, such as: `{{variable name.method name (method parameter)}}`;

## Linkage

Linkage is an interactive function of data visualization, which allows users to view a data view, and the selection or operation made can affect other related data views in real time;

In simple terms, the selection you make on a chart will make other charts "move" and show more information related to your selection;

## Drilldown

Drilldown is an operation to drill down into data details, which allows users to drill down from the current data level to a lower level of data level, so as to view more detailed information about the data.