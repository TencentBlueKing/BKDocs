# Data classification strategy

> Different permission control strategies are adopted for data of different sensitive levels.

Divide business data into four sensitivity levels, and define data at different sensitivity levels from the perspective of data impact scope. Generally speaking, the data content involves key data such as revenue and characteristics. Data that will have a greater impact on the business once leaked has a higher sensitivity level. Currently only the private level is supported for user selection.

In addition to defining the data sensitivity classification, it also provides corresponding management capabilities to ensure the security of highly sensitive data. The platform ensures data security from the "Table Visible Range", "Default Users" and "Approval Process" respectively.



## Sensitivity classification definition

- Basic definition

> - Private data: The business leader directly accesses the platform, which is visible to business personnel. Platform users can apply for this data.
> - Public data: After access, all users of the platform can use this data

- Multidimensional definition

| **Sensitivity** | **Access Permission** | **Table Visible Range** | **Default Users** | **Subsequent Data Use Approval Process** |
| ------------ | --------------------- | ------------- | ------------------------ | ---------------------------------------------------------- |
| **Business private** | No permission required | Table structure | Data administrator + business operation and maintenance | Can apply, any platform user can apply, and needs approval from business side personnel, who include data administrators and business operation and maintenance . |


## Approval process for data with different sensitive levels

According to different data levels, different levels of business parties are selected to approve data.

When the result data table does not have a data administrator, the default business party is the operation and maintenance personnel. Click to view [How to apply for business data approval permissions] (./permission.md)

![image-20200420175948178](sensitivity.assets/sensitivity_private_flow.png)


## Sensitivity inheritance mechanism

Similar to the data administrator mechanism, sensitivity inheritance is carried out according to [blood relationship](../datamarket/data-dictionary/concepts.md).



## Prerequisites

For business operation and maintenance personnel to conduct data approval, platform administrators need to perform [Business Permission Configuration] (./system.md) in the BlueKing Permission Center.