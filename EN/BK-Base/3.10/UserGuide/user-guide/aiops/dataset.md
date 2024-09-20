# Sample set

The sample set function needs to be used in scenario modeling. The complete process is as follows

1) Confirm the scenario: Confirm the modeling scenario according to the requirements;

2) Sample preparation: construct sample data and label it;

3) Feature engineering: During model construction and model application, different data streams will go through the same steps;

4) Model training & evaluation: Select an algorithm for training, and adjust hyperparameters based on the evaluation results;

5) Release model: including the release and management of model records;

6) Apply model: apply business data to the published model;

7) Sample closed loop: In scenario modeling, model users will be provided with annotation feedback function of application data. The model detection results after manual confirmation and modification will be fed back to the sample set as labeled sample data for subsequent optimization and upgrading of the model, forming a closed loop. In the single-index anomaly detection scenario, from the construction of the sample set to the use of the sample set (model construction), the flow chart is shown as follows, in which the red box part depends on sample set management:

![image-20210508162319135](./assets/00.png)


# manual

## Create sample set

Users can create sample sets under their own projects, and the entrance is in the user center. Currently, only sample set management of custom scenarios is supported.

![image-20210508162337118](./assets/image-20210508162337118.png)

## Add sample data configuration

Sample data can be added in the sample data tab. First, select the result data where the sample to be added is located.

![image-20210508162345376](./assets/dataset002.png)

![image-20210508162345376](./assets/dataset003.png)

Result data can be grouped as needed.

![image-20210508162351221](./assets/dataset004.png)

After selecting the result data, you can configure/map other characteristic fields of the result data. When sample data is added for the first time, the fields and data frequencies of the result data will be used as the original fields and data frequency standards of the sample set and cannot be modified. Other result data added subsequently must meet this standard.

![image-20210508162401588](./assets/dataset005.png)

Confirm the time series attributes. If the frequency is inconsistent with the sample set data, aggregation is required.

![image-20210508162407097](./assets/image-20210508162407097.png)

## Add and delete sample data

Add an [Automatically add samples] policy to automatically import data into the sample set. Currently, three types of addition methods are supported: result data, application data, and API.

![image-20210508162412668](./assets/dataset006.png)

[Automatically add samples - result data], automatically add one or more result data in the current sample set

![image-20210508162412668](./assets/dataset007.png)

[Automatically add samples - Application data], you can view and manage the result data of application feedback enabled in the [Model Application] node of [Data Development] here.

![image-20210508162412668](./assets/dataset008.png)

[Automatically add samples - API], you can write data to the sample set through the interface.

![image-20210508162412668](./assets/dataset009.png)

You can also add or delete a specific range of data through the [Customized Sample Add/Delete] policy.

![image-20210508162412668](./assets/dataset010.png)

Through the [Frequency Normalization] strategy, data with non-sample set frequencies can be aggregated into sample set frequencies.

![image-20210508162412668](./assets/dataset011.png)

Aggregation functions can be configured uniformly or separately for each feature.

![image-20210508162412668](./assets/dataset012.png)

## Label sample data

First add the label definition.

![image-20210508162417215](./assets/dataset013.png)

![image-20210508162517203](./assets/dataset014.png)

Then label the sample data. Currently, only sample data annotation is supported through the [Annotation Mapping] strategy. It can be done in two ways: [Value Mapping] and [Script Mapping].

![image-20210508162525078](./assets/dataset015.png)

![image-20210508162529457](./assets/dataset016.png)


## Submit sample set

Once you have finished editing your sample set, you can submit it.

![image-20210508162538180](./assets/dataset017.png)

Wait for the calculation task to be completed before you can preview the data.

![image-20210508162629314](./assets/dataset018.png)

The Basic Information tab can also view various properties and overviews of the current sample set.

![image-20210508162633895](./assets/dataset019.png)