# Why are log queries empty?

Generally, there are several reasons why log queries may return empty results:

## Using a development framework, but the log printing method is incorrect

Please refer to the `README.md` file under the development framework to check the usage of logs.

## Not using a development framework

If you are not using a development framework, then you need to print and store your log files according to the platform's log collection rules.

Currently, BlueKing logs only support the collection of structured log files in JSON format; log lines in other formats will be discarded.

Developers need to output the log files to a specific path according to the agreed rules (for applications that are already using a development framework, you can use the default configuration).

The log path is:

```
/app/v3logs/
```

At the same time, the file name must follow a pattern:

```
$BKPAAS_PROCESS_TYPE-xxxx-${stream}.log
```

Where `$BKPAAS_PROCESS_TYPE` will determine which application process the log belongs to, and the specific value can be directly obtained from the environment variables.

`${stream}` determines the classification of the log in the frontend query stream field, which currently supports:

- component
- celery
- django
- mysql
- json
- `xxxx` is a random string used for unique file identification.

It is important to note that the file needs to be in JSON format, with two required fields:

- asctime, the log generation time, in the format YYYY-MM-DD HH:mm:ss,SSS
- message, the specific log content

## Incorrect query conditions

The log query page is similar to Kibana and supports ElasticSearch query syntax. If there are mutually exclusive query conditions, please clear the query conditions and try again.

## Querying logs older than 14 days

Currently, the platform only saves application logs for 14 days; logs older than 14 days will be deleted. If you have more log query needs, you can contact BlueKing Assistant.

## Log printing frequency is too high

The collection side has implemented flow control based on the **application** dimension, with **a maximum of 6000 logs collected per minute per application (shared quota among modules)**. If the number of logs exceeds this limit, they will be discarded by the collection side and will not fall into the ElasticSearch cluster (they are still on the hard drive, and if you still need to view them, you can contact BlueKing Assistant within two days of logging to assist with exporting).

## Single log entry is too large

The maximum size for a single log entry is **100KB**; if it exceeds this size, it will not be collected. Please try to avoid printing overly large logs.