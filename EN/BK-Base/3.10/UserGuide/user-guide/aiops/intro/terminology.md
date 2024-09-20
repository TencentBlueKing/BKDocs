# Terminology explanation

- Sample set: the data set used for model training
- Model experiment: In the model development stage, the algorithm is trained using sample sets to determine model parameters, including model training, evaluation, and output of alternative models.
- Training set and validation set: Divide the samples into training set and validation set, which are used to train the model and test the model effect respectively.
- Model: Use the sample set to train the algorithm and determine the model parameters and the output object
- Model release: Among multiple model experiments in a model project, select a model experiment that meets expectations and set it as an online version. Once published, the model can be used in data development tasks.
- Model application: Provide model services after applying published models in data development. It supports real-time and offline model application of result tables, and also supports API mode to provide model services.
- Continuous training: Allow the model to adapt to changing business data, and periodic or perceptual model input data changes trigger continuous training.
- Scenario services: In the field of operation and maintenance, some specific activity scenarios generated during the business operation and maintenance process include anomaly detection, root cause location, fault self-healing, intelligent changes, and even some more complex composite operation and maintenance scenarios.