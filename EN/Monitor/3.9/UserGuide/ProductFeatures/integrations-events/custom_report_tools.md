# Customize the reporting command line tool

Customized reporting can be reported through command line tools to send custom data such as custom events/custom timings.

Supports custom reporting through gse agent and bkmonitorporxy (http interface). jsonschema verification will be performed locally before reporting.

## Step one: Apply for data ID

**Navigation Location**: Navigation → Integrations → Custom Metrics/Events



## Step 2: How to use the command line

```bash
# Output help information (actual output is more, send custom data related parameters with the report keyword)
:!./bkmonitorbeat -h
Usage of ./bkmonitorbeat:
   -report
     Report event to time series to bkmonitorproxy
   -report.agent.address string
     agent ipc address, default /var/run/ipc.state.report (default "/var/run/ipc.state.report")
   -report.bk_data_id int
     bk_data_id, required
   -report.event.content string
     event content
   -report.event.name string
     event name
   -report.event.target string
     event target
   -report.event.timestamp int
     event timestamp
   -report.http.server string
     http server address, required if report type is http
   -report.http.token string
     token, , required if report type is http
   -report.message.body string
     message content that will be sent, json format
   -report.message.kind string
     message kind, event or timeseries
   -report.type http
     report type http or `agent`
```

### Usage examples

The basic usage section provides general usage methods, which are suitable for reporting custom events and custom time series data. Since the event content involves the processing of many special characters, the reporting method for custom events will be introduced separately later.
The following code demonstrates the data used to send custom events (the json content comes from the help information on the right side of the monitoring plug-in configuration).

```bash
#Send custom events through gse agent, no return
./bkmonitorbeat -report -report.bk_data_id 1500512 \
-report.type agent \
-report.message.kind event \
-report.message.body '{
     "data_id":1500512,
     "access_token":"991146b7e97b409f8952d59355b5f5c7",
     "data":[{
         "event_name":"input_your_event_name",
         "target":"10.0.0.1",
         "event":{
             "content":"user xxx login failed"
         },
         "dimension":{
             "amodule":"db",
             "aset":"guangdong"
         },
         "metrics":{
             "field1":1.1
         },
         "timestamp":1591067660370
         }
     ]}'

  #Send custom events through http, return code200 successfully, result true
./bkmonitorbeat -report -report.bk_data_id 1500512 -report.type http -report.http.server 10.0.0.1:10205 -report.message.kind event -report.message.body '{
     "data_id":1500512,
     "access_token":"991146b7e97b409f8952d59355b5f5c7",
     "data":[{
         "event_name":"input_your_event_name",
         "target":"10.0.0.1",
         "event":{
             "content":"user xxx login failed"
         },
         "dimension":{
             "amodule":"db",
             "aset":"guangdong"
         },
         "metrics":{
             "field1":1.1
         },
         "timestamp":1591067660370
         }
     ]}'
{"code":"200","message":"success","request_id":"4a6b1b1e-0af0-4834-87c5-6443662df7d3","result":"true"}
```

### Report custom event data through gse agent

This example uses the method of separately specifying each reporting field to solve the troublesome problem of assembling json.

```bash
#Send custom event data by specifying each field, using the default time
./bkmonitorbeat -report \
-report.type agent \
-report.message.kind event \
-report.bk_data_id 1500512 \
-report.event.target 10.0.0.1 \
-report.event.name xxxxxxxxx \
-report.event.target yyyyyyyyy \
-report.event.contentzzzzzz
```

```bash
#Send custom event data by specifying each field and specify the reporting time
./bkmonitorbeat -report \
-report.type agent \
-report.message.kind event \
-report.bk_data_id 1500512 \
-report.event.target 10.0.0.1 \
-report.event.name xxxxxxxxx \
-report.event.target yyyyyyyyy \
-report.event.content zzzzzz \
-report.event.timestamp 1595944620000
```

### Report custom event data through bkmonitorproxy

```bash
./bkmonitorbeat -report \
-report.type http \
-report.http.server 10.0.0.1:10205 \
-report.http.token 991146b7e97b409f8952d59355b5f5c7 \
-report.message.kind event \
-report.bk_data_id 1500512 \
-report.event.target 10.0.0.1 \
-report.event.name xxxxxxxxx \
-report.event.target yyyyyyyyy \
-report.event.contentzzzzzz
```

### Effect View

**Navigation Location**: Navigation → Integrations → Custom Metrics/Events → Inspection Views