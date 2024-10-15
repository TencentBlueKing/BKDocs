 # FAQ 

 1. Does the Standard OPS Standard Plugin support user access to the IT system in the enterprise? 

 Yes, please refer to [Appendix 2: Standard Develop Plugin](../Appendix/Django.md)。 

 2. An error is reported after the Standard OPS click Start to execute the Task: `taskflow[id=1] get status error: node(nodee37e20... c7fb131) does not exist, may have not by executed`, and view Task Total is` Unknow `in the Tasks, what may be the reason? 

 The Standard OPS execute engine relies on the RabbitMQ Service of BlueKing and the Celery process Start Up by the pleaseLogin the server to Confirm that the service Started and Run normal. You can Check the celery.log log file of the App to help locate the cause of the problem. 

 3. The Standard OPS can execute the Task, but the Standard Plugin Node reports an error: `Trackback…TypeError:int() argument must be a string or a number,not` NoneType'`, what might be the reason? 

 The execute Status of standard OPS Task Flow and the cache of Standard Plugin Input and Output information rely on Redis Service. Therefore, for the first Deploy, you must setting Redis Env Variables According to [Standard OPS Deployment The document] and then Deploy again. 