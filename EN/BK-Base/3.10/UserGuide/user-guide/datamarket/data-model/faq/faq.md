Data Model FAQ
----

### What problem is the data model solving?
Standardize the team's data development specifications, such as how to define indicator statistical calibers, how to generate indicators, and how to standardize table names. For details, see [Why data model design] (../concepts.md).

### Which data development teams is the data model suitable for?
- There are multiple data developers in a team, hoping to unify data development specifications through tools
- A set of data development and processing logic that can be applied to multiple businesses. For example, in the mobile game game analysis scenario, if the data input for different businesses is standard, then a data model can be created and applied to multiple businesses. (Call the data model API and instantiate the data development task)
- Maintain a large number of common, fixed logic data development task templates through data development JSON templates, which leads to high maintenance costs

### What are the tasks behind the data model application node?

![-w1752](media/16379996242786.jpg)

In data development tasks, behind the three nodes of the data model are actually real-time computing or offline computing tasks. There is no need to worry about the application performance of such nodes.
- Data model application node: real-time calculation (no window)
- Model instance metrics (real-time): calculated in real time
- Model instance indicators (offline): offline calculation