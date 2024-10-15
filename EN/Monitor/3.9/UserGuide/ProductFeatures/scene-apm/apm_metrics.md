# APM indicator description

### Apdex

Apdex (Application Performance Index) is an industry standard developed by the Apdex Alliance for evaluating application performance. The Apdex standard starts from the user's perspective and converts the performance of application response time into the user's satisfaction evaluation of application performance in a quantifiable range of 0-1.

**Principle of Apdex**
Apdex defines the optimal threshold for application response time as T (that is, the Apdex threshold, T is determined by the performance evaluator based on expected performance requirements). Three different performance performances are defined based on application response time combined with T:

| Performance | Description | Examples |
| ------------------------------------- | --------------------------------------------- | --------------------------------------------------------- |
| Satisfied<br> | The application response time is less than or equal to T. | For example, if T is 1.5s, a response result that takes 1 second can be considered Satisfied. |
| Tolerating<br>| The application response time is greater than T, but less than or equal to 4T. | For example, if the T value set by the application is 1s, then 4 × 1=4s is the upper tolerance limit of the application response time. |
| Frustrated<br> (Frustrated period) | Application response time is greater than 4T. | - |


![](media/16618536365287.jpg)

### Error rate/number

The error rate refers to the ratio of the number of errors (including errors in the module itself, host errors, HTTP access errors, network errors, etc.) in applications, services, interfaces, etc. within a certain statistical period to the total number of requests (or calls/accesses). epm (Error Per Minute) represents the number of errors per minute.

### Response time

In a single interface transaction, the time it takes from the user issuing a request for the interface to the time the interface receives a response.

### Number of calls

Keynote/Keynote

The number of times the interface is called during the running process of the service.

### Gold Indicator

Indicators in the indicator selector

* Time consuming bk_apm_duration
* Number of calls bk_apm_count
     * Statistical method: count
* Maximum time-consuming bk_apm_max_duration
     * Statistical method: max
* Total time spent bk_apm_sum_duration
     * Statistical method: sum
* Number of errors bk_apm_error_count
     * Dimensions: span_name,service_name,kind,resource.bk.instance.id,attributes.peer.service,bk_app_name,bk_biz_id
     * Condition: kind == 2 status.code = 2
     * Statistical method: count
* Number of slow queries bk_apm_frustrated_count
     * Dimensions: span_name,service_name,kind,resource.bk.instance.id,attributes.peer.service,bk_app_name,bk_biz_id
     * Condition: apdex_type==frustrated
     * Statistical method: count
* Number of normal queries bk_apm_satisfied_count
     * Dimensions: span_name,service_name,kind,resource.bk.instance.id,attributes.peer.service,bk_app_name,bk_biz_id
     * Condition: apdex_type==satisfied
     * Statistical method: count
* Number of tolerable queries bk_apm_tolerating_count
     * Dimensions: span_name,service_name,kind,resource.bk.instance.id,attributes.peer.service,bk_app_name,bk_biz_id
     * Condition: apdex_type==tolerating
     * Statistical method: count
* Number of callees bk_apm_call_count
     * Dimensions: span_name,service_name,kind,resource.bk.instance.id,attributes.peer.service,bk_app_name,bk_biz_id
     * Condition: kind == 2|4
     * Statistical method: count
* Number of main calls bk_apm_request_count
     * Dimensions: span_name,service_name,kind,resource.bk.instance.id,attributes.peer.service,bk_app_name,bk_biz_id
     * Condition kind == 3|5
     * Statistical method: count