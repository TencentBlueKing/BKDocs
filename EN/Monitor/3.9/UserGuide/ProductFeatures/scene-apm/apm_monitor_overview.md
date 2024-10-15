# Enable APM monitoring

## What is APM


![](media/16916522683038.jpg)

APM (Application Performance Monitoring) is application performance monitoring. It analyzes software problems through service calls between application software, allowing for more fine-grained monitoring and satisfying users with a better experience. APM specifically needs to solve three problems.


### User troubleshooting process

The user has clearly known that there is a fault and can accurately reproduce and locate the problem.

* The first type: Only the time period and service in question need to be narrowed down and searched upstream and downstream. Call chain query mode. (internal wrong filter)
* The second type: You have obtained a clear traceid for detailed inspection. It is possible that the traceid obtained is broken or has not been collected.

     * Need to be stained (clearly which traceid must be collected, or a specific userid, vip type must be collected and not discarded)
     * Real-time analysis (no sampling, no data loss for 5 minutes)
* The third method: Find out which instance has the problem, and start reverse checking. Where is the specific problem?
* The fourth method: clearly know which service has a problem, and then check the service including the instance

### Routine inspection process

Users do not yet know their service status, relevant monitoring is not yet complete, or they need to conduct an overall review after monitoring alarms.

* Look at the overall situation to see if it meets expectations. Topology, golden indicators, TOP data.
* Diagnosis of architecture: Application topology, slow links

     *SQL analysis
     * Hot key, big key (response size)

* Check the version changes after the version is released
* Reports (user-defined content that users care about)
* Error log statistics, log clustering, log analysis

### Take the initiative to report problems

No one has complained about user access, and users are proactively informed of the system status through indicator data and intelligent monitoring data statistics.

*application dimension
* service dimension
*Interface dimension
* instance dimension
* Error log
* Custom dimensions

## Related concepts

#### Business Business

Physical isolation of management and resources, and the most basic namespace in the configuration platform

#### Application Application

Applications generally have independent sites, are composed of multiple services to provide complete functions, and have independent software architecture. From a technical perspective, it is the storage isolation of Trace data, and data within the same application will be counted and observed.

#### Service Service

Independent modules in microservices independently complete a function. Generally, the same program can be considered to be a Service, and each process formed is a service instance.

#### Interface Resources

The process of processing an independent access request in an application includes HTTP requests, DB queries, middleware operations, etc.

#### Errors

When an exception occurs and causes this interface request to be an error, the error status will be recorded in the field, `span.status_code`, so the presence of logs in Span does not necessarily mean that it is an error, nor does it mean that there must be a log if Status is an error. , there is no absolute relationship between the two, it mainly depends on the output settings. However, it is recommended to use status_code according to the specifications, otherwise the platform cannot calculate the corresponding content.

#### Trace & Span

The two core concepts and data are summary statistics based on TraceID and Span data information.

* Trace: Record request activities through the distributed system. A trace is a directed acyclic graph of spans.
* Span: A trace represents a named, time-based operation. Spans are nested to form a trace tree. Each trace contains a root span, which describes the end-to-end latency, and its sub-operations may also have one or more sub-spans.

#### Opentelemetry

OpenTelemetry merges the OpenTracing and OpenCensus projects to provide a set of APIs and libraries to standardize the collection and transmission of telemetry data. OpenTelemetry provides a secure, vendor-neutral tool so that data can be sent to different backends as needed. The APM SDK of BlueKing Monitoring is fully compatible with the SDK of Opentelemetry.

#### relation

* One business has multiple applications
* There is data isolation between applications
* An application includes N Services
* A Service includes N service instances

## APM application creation

1. You need to create an APM application and set the application name and application English name.
![](media/16618528691936.jpg)

2. Select the plug-in and corresponding language environment, and provide corresponding help documents
3. Select storage and configure storage settings


## SDK reporting data

After creating the application, take the generated Token information, press the reporting address, and report the corresponding data based on different language access.

Please check the [SDK reporting] for each language (../integrations-traces/otel_sdk_golang.md)


## View data

After the data is reported successfully, you can see the data in Data Retrieval->Trace Retrieval at the fastest. In Observation Scenario->Application Monitoring, it takes more than 10 minutes of statistical period to view the corresponding data.

### Trace call chain view

![](media/16618530415573.jpg)


### View application topology

![](media/16618530630491.jpg)