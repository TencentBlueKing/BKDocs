# Segment log collection

For log collection, we hope that the logs are regular, but in actual situations, our log formats may be strange, such as one line of characters and one line of json, and json is divided into lines and is not stored in one line, as shown below

```go
Nov 6 12:06:34 VM_193_66_centos systemd: Starting Cleanup of Temporary Directories...
Nov 6 12:06:34 VM_193_66_centos systemd: Started Cleanup of Temporary Directories.
Nov 6 12:06:34 VM_193_66_centos systemd: Started Cleanup of Temporary Directories.
Nov 6 12:06:34 VM_193_66_centos systemd: Started Cleanup of Temporary Directories.
Nov 6 12:06:34 VM_193_66_centos systemd: Started Cleanup of Temporary Directories.
Nov 6 12:06:34 VM_193_66_centos systemd: Started Cleanup of Temporary Directories.
Nov 6 12:06:34 VM_193_66_centos systemd: Started Cleanup of Temporary Directories.
Nov 6 12:06:34 VM_193_66_centos systemd: Started Cleanup of Temporary Directories.
Nov 6 12:06:34 VM_193_66_centos systemd: Started Cleanup of Temporary Directories.
{
"name": "session.core",
"timestamp": "2021-02-02T11:38:51+08:00",
"line_number": 97,
"function": "get_session_status",
"module": "core",
"level": "INFO",
"path": "/data/app/1.py",
"thread_id": "140620576319232",
"process_id": "28818",
"thread_name": "Thread-188",
"process_name": "Process-8",
"task_logging_status": "None",
"username": "",
"object_id": "",
"object_type": "",
"msg": "The active and exit times are 2021-02-02T01:28:40.980000+00:00/2021-02-02T03:33:40.852000+00:00."
}
{
"name": "close_outdated_sessions",
"timestamp": "2021-02-02T11:38:51+08:00",
"line_number": 148,
"function": "__call__",
"module": "actor",
"level": "DEBUG",
"path": "/data/app/1.py",
"thread_id": "140620576319232",
"process_id": "28818",
"thread_name": "Thread-188",
"process_name": "Process-8",
"task_logging_status": "None",
"username": "",
"object_id": "",
"object_type": "",
"msg": "Completed after 1200.50ms."
}
```

## Segment log configuration

![](media/16619344864271.jpg)