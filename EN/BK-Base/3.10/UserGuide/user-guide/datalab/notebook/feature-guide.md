## Feature Guide

### Offline file upload

#### Features

Notebook provides an offline file upload function, supports uploading CSV files to the platform, and conveniently reads the contents of CSV files in Notebook to generate Pandas DataFrame for data analysis operations, and can generate result tables based on DataFrame data.

#### Tutorial

##### Perform file upload

![](../../../assets/datalab/notebook/feature-guide/file_upload.png)

![](../../../assets/datalab/notebook/feature-guide/file_upload2.png)



##### View data source id and file name

![](../../../assets/datalab/notebook/feature-guide/file_upload3.png)



##### Load the file into Notebook (the CSV file after successful upload is stored in the HDFS cluster. If you need to use it in Notebook, you need to load the file into Notebook first)

```python
DataSet.download_file(raw_data_id, file_name)
"""
:param raw_data_id: data source id
:param file_name: file name

:return: execution result, success or failure, with file usage examples
"""
```

![](../../../assets/datalab/notebook/feature-guide/download_file.png)



##### Display the list of files loaded into Notebook

```python
DataSet.show_notebook_file()
"""
:param raw_data_id: data source id (optional)

:return: File list table display
"""
```

![](../../../assets/datalab/notebook/feature-guide/show_notebook_file.png)



##### Read CSV file to generate Pandas DataFrame

```python
import pandas as pd
df = pd.read_csv('/files/524829/admin_1608602248.csv', encoding='utf-8-sig')
```

![](../../../assets/datalab/notebook/feature-guide/read_csv.png)



##### Generate temporary result table based on DataFrame data

```python
ResultTable.create(dataframe, result_table_id)
"""
:param dataframe: pandas dataframe
:param result_table_id: the name of the created result table

:return: execution result, success or failure
"""
```

![](../../../assets/datalab/notebook/feature-guide/create.png)



##### Subsequent processing

After the temporary result table is created, the user can process the result table accordingly according to the instructions provided by the platform. For data query, refer to [BKSQL syntax] (./bksql.md), and for data update, refer to [Notebook command set] (./command. md).



### Notebook generates reports

#### Features

Notebook supports report generation, and users can generate shareable reports based on Notebook content. For reports generated under a project, the URL can be shared with project members for browsing; reports generated under an individual can only be accessed by yourself.

#### Tutorial

##### Click to generate report

![](../../../assets/datalab/notebook/feature-guide/generate_report.png)

![](../../../assets/datalab/notebook/feature-guide/generate_report2.png)

![](../../../assets/datalab/notebook/feature-guide/generate_report3.png)



##### Browse report content

![](../../../assets/datalab/notebook/feature-guide/report.png)



##### Tips: How to write an outline

![](../../../assets/datalab/notebook/feature-guide/outline.png)

![](../../../assets/datalab/notebook/feature-guide/outline2.png)

![](../../../assets/datalab/notebook/feature-guide/outline3.png)