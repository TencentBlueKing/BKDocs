Group training model
----
Group training: perform batch training on each curve of the sample set (the sample set has grouping turned on), and train a model for each curve.

For example, if a business has 100 servers, and now we are doing CPU usage anomaly detection on these servers, the server IP is a grouping field, and we can train separately for these 100 curves (the CPU usage of each server is one curve) Find a suitable model.

## Preconditions
- Sample opening grouping

## Experiment enable grouping
In the sample segmentation step of the experiment, group training is started.

![-w1919](media/16385153585800.jpg)

In the model training step, you can see that one model is trained for each curve.

Users do not need to deal with grouping characteristics in the algorithm, they only need to deal with a single curve.

![-w1917](media/16385163532597.jpg)

After grouping [Model Release](../release.md), just enable the group application during [Model Application](../serving/serving.md).