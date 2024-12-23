## Data dictionary

Supports users to customize a set of related data values ​​and use these values ​​in the dashboard; not only simplifies the data input process, but also improves data consistency and maintainability;

![dictionary](../media/dictionary.png)

1. Click **`Data Management`** — Click **`Variable/Dictionary`** — Click **`New`**

![create-dictionat](../media/create-dictionaty.png)

2. **Fill in data dictionary information**

​ **`Data dictionary name`**: specific name, the dictionary can be referenced by the data dictionary name in the chart configuration;

​ **`Data dictionary identifier`**: This identifier is used as a variable to guide the chart configuration "SQL mode";

​ **`Data dictionary description`**: a detailed overview of the data dictionary content, which is convenient for quick understanding and use;

​ **`Dictionary data`**: divided into **`Manual entry`** and **`Dynamic acquisition`**;

​ **`Manual entry`**: one-to-one input in table form **`Value (actual value)`** and **`Lable (display value)`**, that is, the value in the actual data set corresponds to the display value after using the data dictionary;

​ **`Dynamic acquisition`**: divided into **`Specified data set`** and **`Custom SQL`**;

![dictionary1](../media/dictionary1.png)

​ **`Specified data set`**: Select the specified **`Data source`**, **`Data set`**, **`Value field`** and the corresponding **`Lable field`**;

![dictionary2](../media/dictionary2.png)

​ **`Custom SQL`**: Output SQL statement to specify the **`Value field`** and the corresponding **`Lable field`** of a data set

3. **Take manual entry as an example:**

![dictionary-example1](../media/dictionary-example1.png)

Create a set of dictionaries in advance, the data dictionary name is the male and female translation dictionary, and then apply this dictionary in the chart configuration;

![dictionary-example2](../media/dictionary-example2.png)

The initial gender of employees in this chart is F and M;

![dictionary-example3](../media/dictionary-example3.png)

Click the employee gender setting button - select value translation - select the male and female translation dictionary - click query;

![dictionary-example4](../media/dictionary-example4.png)

In the chart, female replaces F and male replaces M;