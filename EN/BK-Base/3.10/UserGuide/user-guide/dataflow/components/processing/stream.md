# Real-time calculation

The traditional big data computing model completely separates online data processing and offline data analysis in terms of time series. With the continuous development of business and technology, people's demand for high timeliness and operability of information continues to increase. It is obvious that this architecture can no longer meet the real-time processing needs of big data.

The value of data decreases with the passage of time, so it is particularly important to calculate and process the data immediately after it occurs. The generation of real-time computing is a process of people mining the value of data. In many scenarios such as real-time recommendation, monitoring and warning, real-time prediction, financial transactions, etc., traditional big data processing cannot meet the business needs. As a computing model for streaming data, real-time computing can handle the business needs of big data in real time and efficiently.

- Real-time, unbounded data source

Streaming data is calculated and consumed in real time in chronological order. And due to the persistence of data generation, data flows will be integrated into real-time computing systems for a long time and continuously. For example, a game's login log stream will be generated and entered into real-time calculations as long as the game is running normally. . Therefore, for real-time computing, the data is real-time and unterminated\(unbounded\).

- Continuous and efficient computing

   Real-time computing is an "event-triggered" computing model, and the trigger source is the above-mentioned unbounded streaming data. Once new stream data enters the real-time calculation, the real-time calculation immediately initiates and performs a calculation task, so the entire real-time calculation is a continuous calculation.

__For details, see [Real-time Computing](../../stream-processing/concepts.md)__