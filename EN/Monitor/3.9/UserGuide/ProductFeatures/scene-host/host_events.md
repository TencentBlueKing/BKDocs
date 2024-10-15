# Operating system-system event description

System events are built-in event judgments for host operations and process classes.

### Agent heartbeat lost

* Meaning: Monitor whether the GSE Agent is normal
* Collection method:
     * exception before 1.7.0: gse checks agent heartbeat data every 60 seconds. Starting from the agent's last heartbeat data update, gse triggers an alarm event each at the 5th minute, 10th minute, and 12th hour. Starting from the 24th hour, if the heartbeat is still not updated, the above process of triggering an alarm event at the 5th minute, 10th minute, and 12th hour will be repeated.
     * exception after 1.7.0: No convergence, once every minute for 24 hours
* Depends on: GSE service reporting

### Disk read only

* Meaning: Monitor the read-only status of the disk
* Collection method: Linux
     1. Depend on bkmonitorbeat collector, install it in node management
     2. Determine the file status ro of the mounted disk, similar to the Linux command: `fgrep 'ro,' /proc/mounts`

### Disk is full

* Meaning: Monitor the full status of the disk
* Collection method:
      * Linux: relies on bkmonitorbeat collector, installed in node management

### Corefile generation

* Meaning: Monitor changes in files in the directory /proc/sys/kernel/core_pattern
* Collection method: Linux
      1. Check the corefile generation path: `cat /proc/sys/kernel/core_pattern`, make sure it is in a certain directory, such as `/data/corefile/core_%e_%t`
      2. Rely on the bkmonitorbeat collector and install it in the node management. It will automatically monitor the file directory according to core_pattern.

### Unreachable by Ping

* Meaning: Monitor the ping status of the controlled server
* Collection method:
      1. Depends on the installation of bkmonitorproxy collector. Please contact the administrator for installation in directly connected areas. It will be installed automatically in non-directly connected areas.
      2. Use the monitoring background bkmonitorproxy to detect whether the target IP is alive.
* Support: All managed servers.

### Process port

* Meaning: The process port is blocked
* Collection method:
      1. Linux: bkmonitorbeat reports data matching
      2. Windows: `wmic path win32_process get */value` and `netstat -ano`

### Host restart

*Meaning: Monitoring system starts abnormal alarm
* Collection method: Linux
      1. Rely on the installation of bkmonitorbeat collector, install it in node management
      2. Detection principle: By comparing the last two uptime data, if `cur_uptime < pre_uptime` is satisfied, it will be judged as a restart, and it will be judged whether it has been reported in the previous 25 minutes. If not, it is considered to be a boot and not a restart.


### OOM alarm collection principle description
    
- illustrate
     The OOM alarm information in BlueKing monitoring is collected by the bkmonitorbeat collector. There are two sources for OOM alarm information collection: kernel log and oom_kill counter in /proc/vmstat. The collection and matching logic of the two sources will be explained below.

- Collector principle
     1. kernel log
         - Collection principle
             bkmonitorbeat is called through Syscall to obtain the log information in the current buffer of the kernel, and then matches the keyword `ut of memory:`. If there is a matching result, the collector considers that an OOM event has occurred in the system and reports the OOM alarm information.
             > Note: Since the kernel log buffer will be cleared, dmesg may not print the log content at any time.
         - equivalent script
            
             ```bash
                 dmesg | grep 'ut of memory:'
             ```
     2. oom_kill counter
         - Collection principle
             In the Linux 4.13+ kernel version, the oom_kill counter is added, which records the number of times the OOM Killer is activated. If it is found that the number of oom_kill collected this time has increased compared with the previous cycle, an OOM alarm will be reported.
             > Note: Since the OOM event is detected from the counter, the generated OOM event cannot provide specific process information, and will be uniformly recorded as System OOM.
         - equivalent script
            
             ```bash
                 grep 'oom_kill' /proc/vmstat
             ```

- common problem
     1. Don’t see the oom_kill keyword in /proc/vmstat?
         As mentioned above, this keyword is added in Linux 4.13+, please confirm the machine kernel version with `uname -a`

     2. What is the priority of the two collection methods?
         In order to collect OOM process information as much as possible, the bkmonitorbeat collector will first match the keywords in the kernel log. If there is no keyword hit in the kernel log, check whether the oom_kill counter in /prom/vmstat has increased.

     3. How long is the collection cycle of the collector?
         Since the kernel log buffer may be cleared, bkmonitorbeat checks the kernel log every 10 seconds by default. If you need to adjust the frequency, you can modify the bkmonitorbeat collector configuration:
        
         ```yaml
         exceptionbeat:
             check_oom_interval: 10 # Unit seconds
         ```