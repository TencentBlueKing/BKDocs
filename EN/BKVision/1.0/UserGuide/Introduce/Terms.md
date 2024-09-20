# Terminology Explanation

This article introduces some terms and basic concepts unique to the BlueKing chart platform.

## Dimension

Specify descriptive attributes or features of an object with different values, usually a categorical variable, for example:

- Time dimension: group data by time periods such as day, week, month, etc.

- Geographic dimension: segment data according to the country, region or city where the user is located;

- User dimension: analyze data according to user attributes such as age, gender, occupation, etc.

- Product dimension: organize data according to product category, function or price;

## Indicator

Used to measure the performance of a business or product, usually some numerical variables, such as sales, number of users, conversion rate, etc.

## Variable

- Component variable: interactive component in the dashboard, "component identifier" is the variable name, including: drop-down selector, selection box, time selector; "component variable" is suitable for dynamic filtering and filtering of chart data in the dashboard. When the same batch of charts want to support dynamic selection of condition range to display data, use interactive components and configure the associated scope (chart) or reference "component variable" in SQL to meet the requirements;

- Constants: Custom variables added in the dashboard. Unlike "component variables", "constants" will not be displayed in the dashboard. They are only used as parameter configurations for data query logic. They only work when the dashboard is rendered and cannot be interactive or dynamically changed. "Constants" are generally applicable to global parameter setting scenarios of charts, such as project ID, business ID, etc.

## "Variable tail"

Variable tail is a unified predefined variable processing function method provided by the platform. Users can use this ability to change the output format or content of the variable;

The usage is just like its name, just append the method name to the end of the variable name, such as: `{{variable name.method name (method parameter)}}`;

## Linkage

Linkage is an interactive function of data visualization, which allows users to make choices or operations when viewing a data view to affect other related data views in real time;

In short, the choice you make on a chart will make other charts "move" and show more information related to your choice;

## Drill down

Drill down is an operation to drill down into data details. It allows users to drill down from the current data level to a lower level of data level to view more detailed information about the data;