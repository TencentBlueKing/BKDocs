# Introduction to machine learning functions

In order to better meet users' data mining and intelligent operation and maintenance needs, we provide a series of scenario-based process modeling tools. Users can build and apply models through process-based templates and guidelines. This modeling tool exists in the form of a node under the Machine Learning category in the DataFlow component library. The usage process flow chart of this node is as follows:

![](../../assets/process-model/2.jpg)

The following chapters begin to introduce the use process of this modeling tool based on the interface.
Note 1: Users need to understand some basic concepts of data mining when reading the following documents, such as sample set, training set, verification set, feature engineering, model evaluation and other concepts.
Note 2: Sample set management and closed-loop related functions are still in internal testing and have not yet been launched.

## Configure model

Users can create models under their own projects. For information on creating projects, please refer to [My Project](fu-wu-gong-neng-jie-shao/ge-ren-zhong-xin/wo-de-xiang- mu.md).
The entrance to creating a model is in the Component Library - Machine Learning directory. Currently, it only supports anomaly detection scenarios (used for anomaly detection on time series type data).
First, drag an anomaly detection node to the canvas

![](../../assets/process-model/企业微信截图_15611093733587.png)

Set up a connection

![](../../assets/process-model/企业微信截图_15611094362138.png)

Currently model nodes allow connections from the following types of nodes

1. Offline data node
2. Real-time data node
3. Offline computing nodes
4. Real-time computing nodes

Double-click to pop up the model's configuration panel.

![](../../assets/process-model/企业微信截图_15613433358893.png)

If there is a model that has been built, you can directly select it in the model name drop-down box. If you need to create a new model, you can click Create Model in the drop-down box. For subsequent steps, please refer to [Create Model] (fu-wu-gong-neng-jie -shao/shu-ju-kai-fa/process-model.md).
You can click Details to view the details of the selected model, or set an alias for the node in the node name input box. You can also choose whether to automatically update the model according to your needs.
Note that single-index anomaly detection models usually require historical dependencies of a certain length of time for feature extraction. If the upstream data of the current connection does not meet the length of time, the following error will appear.

![](../../assets/process-model/企业微信截图_15613435771300.png)

Once you select a model, you can proceed to fill in the field mappings.
Fill in the configuration of the model output, including the table name, Chinese name, and field alias of the output table.
For offline type nodes, you can also fill in the application period and window length at the end.

![](../../assets/process-model/企业微信截图_1562899323874.png)

## Create model

When creating a model for the first time, a guidance page will pop up.

![](../../assets/process-model/企业微信截图_15592048759994.png)

Click Start Modeling to enter the model creation page. First, select the timing anomaly detection scenario, then fill in the basic information of the model, and click Create Model to enter the model building steps.

![](../../assets/process-model/企业微信截图_15592050837396.png)

## Build model

### Sample set

First select a sample set. If you need to create a new sample set, please click Create Sample Set in the drop-down box. For the operation of creating a sample set, please refer to [Sample Set](.).
In the advanced panel on the right, you can view the sample set details, each sample data curve, and sample distribution.
You can also modify the data division ratio (the sample data ratio of the training set and the validation set). Note that modifying this ratio will affect the model effect.

![](../../assets/process-model/企业微信截图_15613436589075.png)

### data processing

Data processing includes data preprocessing and feature engineering of the sample set (application data when the model is applied). The processed features will be used for algorithm training.
After selecting the sample set, a set of data processing node templates will be automatically loaded for you. You can add or delete nodes, modify node parameters, and debug nodes according to your needs.

![](../../assets/process-model/企业微信截图_15613442575239.png)

Click a data processing node to select the node. You can modify the parameters of the node in the advanced panel on the right and view the algorithm explanation of the node (including scenario-based explanations and explanations of algorithm principles).

![](../../assets/process-model/企业微信截图_15613438679315.png)

You can modify the pending fields and new output fields of the node. After confirming that everything is correct, click the debug button to run the debugger to the current node. Note: The debugging of data processing nodes is serial. If an error occurs on the previous node, the entire debugging process will be terminated.

![](../../assets/process-model/企业微信截图_15613440959219.png)

You can view the debugging output results in the advanced panel on the right. The output fields include the new output fields of the current node and the output fields of previous nodes. Click each field to view the timing curve and characteristic distribution of the field value.

![](../../assets/process-model/企业微信截图_15592075418697.png)

### algorithm

After selecting the sample set, a set of algorithm templates will be automatically loaded for you. You can add or delete algorithms, modify algorithm parameters, and train algorithm nodes according to your needs.
Click an algorithm node to select the node. You can modify the parameters of the node in the advanced panel on the right and view the algorithm explanation of the node (including scenario-based explanations and explanations of algorithm principles).

![](../../assets/process-model/企业微信截图_1559207877107.png)

You can modify the algorithm input field and algorithm output field of the node. After confirming that they are correct, click the debug button to run the debugger to the current node. Note: The training of algorithm nodes is in parallel. You can train a certain algorithm separately, or you can click the All Training button to train all algorithms.

![](../../assets/process-model/企业微信截图_15595286374572.png)

You can view the output results of the training in the advanced panel on the right. The output fields include the output fields of the algorithm and the output fields of data processing. Click each field to view the time series curve and characteristic distribution of the field value.
For the trained algorithm, click the algorithm evaluation button to switch to the algorithm evaluation tab to evaluate the algorithm training results.

![](../../assets/process-model/企业微信截图_15613472926464.png)

The evaluation content includes abnormal score distribution and multiple types of evaluation indicators (PR, ROC, LIFT, GAIN, KS curve). You can adjust the sensitivity slider (weighing the detection rate and accuracy) to make the abnormal score distribution and assessment metrics to an appropriate standard that meets your needs.

![](../../assets/process-model/企业微信截图_15595308956270.png)

You can also view the comparison of the model detection results and manual annotation results for each sample data below.

![](../../assets/process-model/企业微信截图_1559530840834.png)

Algorithms that have completed evaluation become evaluated.

![](../../assets/process-model/企业微信截图_15613473273089.png)

Click the Next button below to pop up a model selection pop-up box. You can select the best model to generate a model record for the next release operation.

![](../../assets/process-model/企业微信截图_15613473631921.png)

## Publish model

You can view the generated model records in the Publish Model tab. The generated model records have two statuses: published and unpublished. Unpublished model records can be published by clicking the operation button on the right.

![](../../assets/process-model/企业微信截图_15613475432369.png)

The number on the right side of the published model record name indicates the current number of applications of the model. Only model records without any applications can be unpublished or deleted.

![](../../assets/process-model/企业微信截图_15613476064158.png)

Click the evaluation indicator checkbox on the upper left to select the evaluation indicators that need to be displayed. The currently provided evaluation indicators include: accuracy, detection rate, and F1 Score. Each evaluation indicator will be displayed separately according to the training set and validation set. You can also click the display mode switching button on the upper right to switch the display mode of the evaluation indicators. The currently provided display modes include: digital table, bar chart table, and bar chart.

![](../../assets/process-model/企业微信截图_1561358034907.png)

Click on any model record to view or edit the release configuration of the model record in the advanced panel on the right, including: release description, model input, and model output. Published model records can only be viewed but not edited. For unpublished model records, you can edit the release configuration and click the publish button below to publish the model.

![](../../assets/process-model/企业微信截图_15613601521359.png)

If you check Set as the latest model when publishing, you can automatically migrate applications with previously released models to the current model (provided that the application has checked automatic updates). After successful publishing, you will be directed to enter the model's application configuration page, or enter the application model tab to view the application status of the current model.

![](../../assets/process-model/企业微信截图_15613601852898.png)

## Application model

The model can be applied on the application configuration page of the workbench, and the application of the current model can be viewed and managed on the application model tab.

### Application Overview

You can view the task status of all applications of the current model through a pie chart.

![](../../assets/process-model/企业微信截图_15613615291728.png)

### Application List

You can view the specific application information recorded by each model separately, including: application node name, task name to which the application belongs, and whether automatic updates are turned on. You can also perform multiple operations, including migrating the application from the original model record to the latest model record, and setting a model record as the latest model.

![](../../assets/process-model/企业微信截图_1561361546383.png)