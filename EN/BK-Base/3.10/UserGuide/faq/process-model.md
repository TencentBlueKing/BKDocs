# Frequently Asked Questions about Scenario Modeling



## Sample management

### Sample addition

**1. What is the use of sample sets? **

A sample set is a set of time series data marked with anomalies, which may come from multiple curves. The machine learning algorithm obtains an anomaly detection model by learning from sample data.

**2. How to select the curve in the sample set? **

- First, you need to determine the type of business indicators to be monitored, such as success rate.

- Then import historical data of the same type of indicators into the sample set, preferably including failure intervals, such as interface call success rate.


**3. When creating a sample set, what are the requirements for the number of abnormal samples? **

It is recommended that there be more than 100 abnormal samples, accounting for no less than 10% of the total samples.

**4. When creating a sample set, what should we do if there are relatively few real failures? **

It is recommended to use the public sample set provided by the platform and copy the public sample set to the project for direct use; or continue to add your own business data and use it after debugging.

**5. What to do when the added curves have similar shapes but very different dimensions? **

Normalization nodes can be added in feature preparation to eliminate the impact of excessive dimensional gaps in the data.

**6. What features need to be constructed to train the model? **

It is recommended to give priority to the default configuration features; it can be adjusted later based on the evaluation results in [Model Experiment] (see 1.2.3 for details).



### Exception annotation

**1. What is the use of exception annotation? Is it possible not to label it? **

Areas that require alarms in business are called exceptions. Anomaly labeling is equivalent to providing a standard answer to the model, and then training the machine learning model to make the model's abnormal prediction results consistent with the labeled results.

Currently, for single-index anomaly detection scenarios, the platform only provides supervised algorithms, so anomaly annotation is necessary, and the quality of anomaly annotation has a greater impact on the detection performance of the model.

**2. How to label exceptions? **

- Manually determine whether there is an abnormality based on the reference lines of the last day and week;
- Specify abnormal conditions based on business experience and mark exceptions;
- Use the automatic anomaly identification function provided by the platform to annotate anomalies.

**3. What is the use of automatic labeling? how to use? What is the principle? **

Automatic annotation is an auxiliary labeling tool provided by the platform, aiming to improve the efficiency of labeling samples.

Generally, the automatic annotation function is used for preliminary screening, and then the automatic annotation results are manually fine-tuned.

The principle of automatic labeling is 3-sigma anomaly detection.

**4. When annotating abnormalities, what kind of fragments should be selected for annotation? **

Select a period of time before and after the fault occurs for abnormal annotation.



## Model experiment

**1. How to select features? **

You can refer to the feature importance and feature quality given in [Data Distribution] to make a selection; or select based on manual experience.

**2. How to deal with the inconsistency between feature importance and human experience? **

It is recommended to check whether the calculated results are biased due to insufficient sample data or incorrect labeling.

**3. When the model evaluation effect is poor, how to troubleshoot and optimize? **

Follow the following guidelines for troubleshooting:

- Sample data: Check whether the sample data is insufficient or incorrectly labeled;
- Features: Replace sample features; (Tip: If the model effect is not improved after replacing features, it may be because the sample quality is not high and the sample data needs to be reprocessed)
- Model hyperparameters: adjust hyperparameters according to relevant algorithm explanation documents;
- Threshold: Adjust the optimal threshold based on the metrics evaluated by the model.

The investigation flow chart is as follows:

![Flow chart for troubleshooting poor model performance](./media/model-process1.jpg)

**4. What is the use of thresholds in model evaluation? How to adjust the threshold? **

  The threshold in model evaluation is used to decide whether the current anomaly probability requires an alarm. That is, when the abnormality probability is less than the threshold, it is judged as normal; when the abnormality probability is greater than or equal to the threshold, it is judged as abnormal and an alarm is required.

Guidelines for adjusting thresholds:

- Increase the threshold, reduce alarms, increase missed alarms, and reduce false alarms;

- When the threshold is reduced, alarms will increase, missed alarms will decrease, and false alarms will increase.

When both the missed alarm rate and the false alarm rate reach the business launch standard (refer to the test result statistics panel on the right side of the evaluation), the adjustment is completed.