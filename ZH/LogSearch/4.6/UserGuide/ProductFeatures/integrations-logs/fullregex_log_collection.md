# 段日志采集

日志采集，我们希望日志都是规则的，可是在实际情况中，我们的日志格式可能是千奇百怪的，如一行是字符，一行是 json,而且 json 是分行的，不是存储到一行的，如下所示

```go
Nov  6 12:06:34 VM_193_66_centos systemd: Starting Cleanup of Temporary Directories...
Nov  6 12:06:34 VM_193_66_centos systemd: Started Cleanup of Temporary Directories.
Nov  6 12:06:34 VM_193_66_centos systemd: Started Cleanup of Temporary Directories.
Nov  6 12:06:34 VM_193_66_centos systemd: Started Cleanup of Temporary Directories.
Nov  6 12:06:34 VM_193_66_centos systemd: Started Cleanup of Temporary Directories.
Nov  6 12:06:34 VM_193_66_centos systemd: Started Cleanup of Temporary Directories.
Nov  6 12:06:34 VM_193_66_centos systemd: Started Cleanup of Temporary Directories.
Nov  6 12:06:34 VM_193_66_centos systemd: Started Cleanup of Temporary Directories.
Nov  6 12:06:34 VM_193_66_centos systemd: Started Cleanup of Temporary Directories.
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
"msg": "active和exit时间为2021-02-02T01:28:40.980000+00:00/2021-02-02T03:33:40.852000+00:00。"
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

## 段日志配置
对于这样的日志，我们可以使用段日志功能。输入日志样例、行首正则表达式后点击匹配验证。验证通过即可完成行首配置；

![Alt text](media/2024-07-16-11-43.png)

行首配置之后，每一个以行首开头的日志将会被视为一条日志。比较经典的段日志场景如： Java 堆栈日志。从行首开始计算，直到下一次出现行首时，中间的日志都会被视为同一条日志。可通过**最大匹配行数**控制段日志长度，默认为 50 行，避免出现因正则错误而导致日志无线累加。
![Alt text](media/2024-07-16-11-56.png)


