# Custom modeling

The steps for custom modeling are slightly different depending on whether training is performed within the experiment. As shown below:

![](./assets/0.png)

1) In-experiment training: You need to prepare a sample set (training data) on the platform, and select an algorithm for training and evaluation in order to get the model for release and application (not available in this issue);

2) No training in the experiment: model hosting. The model has been trained and packaged offline, uploaded to the experiment to define the model, and then the model can be published and applied.

# Features

## Create model

The entrance to create a model is the same as scene-based modeling. Select the custom scene in the scene information and fill in the model information to complete the creation.

![](./assets/1-1620469158002.png)

After creating the model, you will be shown two development methods for model experiments, namely, the above-mentioned: in-experiment training/no training.

![](./assets/2-1620469160738.png)

## Model experiment

Create a model experiment and select the development method (turn off in-experiment training/evaluation):

![](./assets/3-1620469163567.png)

### Upload model file

After selecting a development method, you can upload the model and define it. Here are some things to note:

1) Currently supported algorithm framework:

Currently supported frameworks are scikit-sklearn 0.21.3 and PySpark MLlib 2.4.4.

2) Currently supported model file sizes and formats

The currently supported model file size for upload is within 35M.

The scikit-sklearn framework supports uploading pkl files, and the corresponding serialization method is Pickle.

The PySpark MLlib framework supports uploading zip files. The corresponding serialization method is the save method that comes with the algorithm, which requires the entire saved folder to be compressed and uploaded.

Please upload the model file according to the specifications and fill in the configuration.

### Selection algorithm

You can choose an algorithm provided by the platform or a custom algorithm, depending on the algorithm used in your model file. The official algorithm can be selected directly, while the custom algorithm must be defined before use.

![](./assets/4-1620469166617.png)

Custom algorithms must fill in the following:

1) Basic information

2) Training/prediction input: required. The input field of the training/prediction function supports variable input (in addition to the configured input when using the algorithm, other inputs can be added)

3) Prediction output: required. Output fields of the prediction function

4) Training parameters: optional. Parameters of the training function

5) Prediction parameters: optional. Prediction function parameters

![](./assets/5-1620469169357.png)

### Apply input

After selecting an algorithm, you can configure the application inputs that the algorithm uses when performing predictions online, including the specifications and fields for the application input data. If the algorithm you are using has specified prediction inputs, these fields will be added here automatically for you, and you only need to fill in the field names of the application inputs.

![](./assets/6-1620469172105.png)

After confirming that the model information is correct, you can submit it.

![](./assets/7-1620469174757.png)

## Model release

You can fill in the publishing configuration in the model publishing tab, and then publish the model online.

![](./assets/8-1620469176892.png)

![](./assets/9-1620469179683.png)

## Model application

The steps for applying the model in the data development workbench are consistent with scenario modeling. For details, please refer to the introduction document of [Single Indicator Anomaly Detection].