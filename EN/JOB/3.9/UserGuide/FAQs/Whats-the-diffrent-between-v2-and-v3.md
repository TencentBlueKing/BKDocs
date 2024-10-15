# What is the difference between the operating platform V3 and V2

In addition to fully adopting the "micro-service" model design in the system architecture, the new version of the operating platform V3 has also achieved a comprehensive improvement in product functions and experience! Similarly, the product architecture and planning also highlight the direction and positioning of platform capabilities, and continue to deepen the two core atomic capabilities of `script execution` and `file distribution`.

<table><tbody>
<tr style="font-weight:bold;"><td width="18%" ></td><td width="41%"> Job-v2 old </td><td width="41% "> Job-v3 new version </td></tr>
<tr><td style="vertical-align:middle;"> Script execution </td><td style="vertical-align:middle;"> Support Shell / Bat / Perl / Python / PowerShell </td><td style="vertical-align:middle;"> Support Shell / Bat / Perl / Python / PowerShell / SQL </td></tr>
<tr><td> File distribution </td><td> Does not support speed limit, does not support timeout setting </td><td> Supports timeout, supports speed limit<br/>Supports different transmission modes </td> </tr>
<tr><td rowspan="2" style="vertical-align:middle;"> Job Template </td><td rowspan="2" style="vertical-align:middle;"> "Template + Job Example "Integrated mode, the parameters and hosts required for the unified configuration and management steps are configured and managed through the method of "global variables". The relationship between job templates and instances is "one-to-one", and each execution needs to check the corresponding steps from the template to execute. </td><td> Pure templates, non-executable; use "global variables" to uniformly configure and manage parameters and hosts required for steps, and manage job instances in different scenarios by generating "execution plans"; job templates and The relationship between instances is "one-to-many". </td></tr>
<tr><td> Changes in the order of steps, additions and deletions of steps, and any modification of parameters/contents of steps (including changes in different versions of scripts) will cause differences between the template and the execution plan! </td></tr>
<tr><td rowspan="3" style="vertical-align:middle;"> Implementation plan </td><td rowspan="3" style="vertical-align:middle;"> - </td> <td> The execution state of the job in Job v3 is renamed "Job Execution Plan". The job instance derived from the template is a real executable job object; when the template is changed, the execution plan will choose whether to synchronize the changes from the template. </td></tr>
<tr><td> The execution plan cannot modify the parameters and execution goals of the steps, which are distinguished by different assignments to "global variables". </td></tr>
<tr><td> When performing scheme synchronization, you can compare the difference details with the template. </td></tr>
<tr><td rowspan="4" style="vertical-align:middle;"> Script Management </td><td> Business and Public Scripts (Global) </td><td> Business and Public Scripts (global) </td></tr>
<tr><td style="vertical-align:middle;"> A script can have multiple versions available at the same time </td><td style="vertical-align:middle;"> A script can only have A version is in the "online version", that is, newly created jobs can only refer to this version (but existing jobs that have already referenced the old version are not affected); the script version status supports "disabled", and disabled scripts will be completely unavailable! It is used to quickly stop losses in emergency or security risk scenarios! </td></tr>
<tr><td style="vertical-align:middle;"> does not support querying job referrers </td><td> supports reverse querying job referrers </td></tr>
<tr><td> - </td><td>Support version comparison</td></tr>
<tr><td rowspan="4" style="vertical-align:middle;"> Host selection method </td><td> Manual entry </td><td> Manual entry </td></tr>
<tr><td style="vertical-align:middle;"> Topology Selection Host </td><td> Topology Selection Host </td></tr>
<tr><td style="vertical-align:middle;"> - </td><td> Topology selects dynamic nodes </td></tr>
<tr><td style="vertical-align:middle;"> Dynamic Grouping </td><td> Dynamic Grouping </td></tr>
<tr><td> Scheduled tasks </td><td> Quartz background + built-in expressions </td><td> Quartz background + Linux-like native Cron expressions </td></tr>
<tr><td> Account management </td><td> Oriented to full business management </td><td> Management by business dimension </td></tr>
<tr><td> Message notification </td><td> Supports message notification of the job executor's own execution success, failure and waiting for confirmation status </td><td> Supports flexible configuration for any business role or person Message notification of successful execution and failure status </td></tr>
<tr><td> High-risk syntax detection </td><td> - </td><td> Supports configuration of high-risk statement reminder rules by script type </td></tr>
<tr><td> IP Whitelist </td><td> Yes </td><td> Yes (no change) </td></tr>
<tr><td rowspan="5" style="vertical-align:middle;"> Global Settings </td><td> - </td><td> Support configuration of message notification channels and templates </td> </tr>
<tr><td style="vertical-align:middle;"> - </td><td> Storage Policy Configuration </td></tr>
<tr><td style="vertical-align:middle;"> - </td><td> Account Naming Rules Configuration </td></tr>
<tr><td style="vertical-align:middle;"> - </td><td> Support high-risk sentence rule configuration by script type </td></tr>
<tr><td style="vertical-align:middle;"> -- </td><td> Support personalized configuration platform information </td></tr>
<tr><td> CMDB data synchronization mechanism </td><td> Delay timing pull </td><td> Through event subscription, second-level synchronization </td></tr>
</tbody></table>