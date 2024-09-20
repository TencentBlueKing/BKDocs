How to do data operations: design, implementation, and use of indicator systems
----
There is no growth without measurement. The cliche in the field of data operations is to build an indicator system.

Here we take the internal platform as an example to introduce the three steps of data operation in the internal system: designing the indicator system, implementing the indicator system, and using the indicator system.


## 1. Build an indicator system
Just like using **one sentence to define your product**, **first select the North Star indicator** (like the North Star, it guides the direction, the terminology in "Growth Hacking" is called core indicator in some places), and guides the team to work hard. kill.

The North Star indicators are different at different stages. In some stages, it may be the breadth of users and the breadth of functions used by users. In other stages, it may be the depth of functions used by users, or it may be the construction of the **Basic Growth Equation** = Number of Active Users* Product Depth used.

After having the North Star indicator, the next step is to decompose the indicator into various functional modules based on the user's usage process;


### 1.1 Platform global indicators
- Core indicators: such as growth trends of users and user assets
- User metrics
     -Activity data: DAU/WAU/MAU/user active days in the last 30 days, new users, UV/PV of each module, PV of each department, activated user growth trend, activated user department distribution
     - Activated user details: the number of valid assets of a single user in each functional module of the platform, the PV of a single user in each functional module in the last week, bubble chart of valid assets, and histogram distribution of valid assets
     - Access business details: the number of effective assets of a single business in each functional module of the platform, and the histogram distribution of effective assets
     - Terminal data: resolution, operating system
- Service indicators
     - Number of data sources, access type distribution, data storage volume, storage usage, daily query times, query application distribution
     - The amount of data development tasks and the amount of data processed
- Performance indicators and costs
     - Daily availability of each module
     - Data query corresponding time distribution
     - Storage space is distributed by business

### 1.2 Indicators of each functional module
In addition to the indicators at the entire platform level, each functional module also needs quantitative indicators. Taking the query visualization of data exploration as an example, we need to know
- How many people use it every day and how many times they use it
-Who are the most active users in the last 30 days?
- Whether in query or used in Notebook
- In which projects is it used?
- Which type of chart is used more often?
- How many times have you enabled grouping, set sorting, and set titles in the chart?

![query_graph](media//query_graph.png)

## 2. Implementation indicator system
After designing the indicator system, it needs to be implemented in the platform;

### 2.1 Data integration: bringing in data
#### 2.1.1 Data access

![-w1273](media/data_access_detail.png)

- log
API call logs of each module to facilitate statistics on interface call success rate and error code distribution

-DB
The configuration tables of each functional module (such as project table, data source configuration table, Dataflow configuration table, etc.) are used to count user usage and are used as dimension tables to associate with other flow tables.

- Interface
The HTTP API of some modules has statistical data, such as the number of offline tasks and HDFS capacity.

- File Upload
Generally used as dimension tables, such as return code and return code Chinese meaning comparison table, used to expand the return code of the module API call log into the Chinese meaning of the return code

- customize
For access types that are not supported by the platform, you can use a custom calling command line to complete data reporting.

     - For example, the embedded data of the background data flow is stored in influxdb, which can be queried by writing scripts such as Shell and then calling the command line for customized access;
     - For example, users' access and click behaviors on the front-end page can be sent to their own encapsulation interface by monitoring the front-end operation events. The interface then calls the custom access command line to complete data access. These data can be used to calculate DAU and PV. , module-specific interactive data;

#### 2.1.2 Data Cleaning
Clean the data accessed above into structured data

![data_clean](media/data_clean.png)

#### 2.1.3 Data storage
- If it is used directly for real-time calculations, there is no need to store it in the database, because the data will stay in Kafka for a period of time by default;
- If you are exploring and analyzing detailed data, and the daily data volume exceeds tens of millions, it is recommended to store it in HDFS. You can use Trino's distributed query engine to speed up the query;
- If the data is directly used for offline calculation, the database is HDFS;
- If used as a dimension table, it will be associated with other tables and stored in ignite;

![data_clean](media/shipper.png)

### 2.2 Data Exploration: Exploring data through SQL queries and Notebooks
Explore data through data exploration queries or notebooks, and then convert it into real-time and offline computing tasks in data development after verification;

![datalab](media/datalab.png)


### 2.3 Data Development: Use SQL for real-time and offline calculations
Routine tasks can be solved using SQL, **do data calculations in advance**, and finally directly query the calculated result data in the visual report to speed up chart loading.

- Real-time calculation
     - Windowless: perform data cleaning, dimension table association, and generate trustworthy detailed data tables, such as associated project tables, extending the project ID to the project name
     - Rolling window: aggregate calculations per minute, such as the number of SQL queries by platform users per minute
- Offline calculation
     - Fixed window: For example, count the number of queries for each business yesterday every day
     - Sliding window: For example, counting the number of queries per person in the last month every day
    
![dataflow_query](media/dataflow_query.png)


### 2.4 Data Visualization
Finally, we need to use visual components such as BlueKing Chart Platform to present indicators and understand user usage in real time.




## 3. Use indicator system
### 3.1 Macro
- Leadership: **Discover problems in data, ask questions, and focus on solving problems**
- Platform-level operations staff: Understand the current operating situation of the platform through operational data, and **operation plans are targeted**

### 3.2 Micro
- Product prototype design stage: identify potential users from the data, and allow **users to participate in discussions and verify the solution**
- Product grayscale launch stage: Find potential users from the data and let users verify whether the product can solve the problem (in big words, it is **PMF, product market fit**)
- The product is officially launched:
     - Proactively discover problems: For example, specially create a user slow query report, and find that massive data query times out. It is recommended that users store it in HDFS, use a distributed query solution based on Trino, and optimize it into product interaction. Good things will spread, based on the query volume of Trino rise quickly
     - Mining user needs: Discover core users, go to users, and dig out needs from users. For example, the platform module has the number of active users in the last 30 days, find out the top 5 active users, and dig out their needs.
     - User consultation: Query the user's level in each functional module through user tags. Only by understanding the user can we better communicate with the user.
     - Quality: Stimulate each module to improve service availability through SLA indicators
     - Verify product design through data: such as the title of query result visualization, sorting, grouping functions, how many people are using these advanced functions

### 3.3 Others
- Everyone paddles to sail the big boat, let development students also participate, and everyone builds operation reports for each functional module to **strengthen the awareness of data operations**
- **Add data burying points into product function planning**, and think of data operations from the beginning of product design