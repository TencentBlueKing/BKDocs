# 脚本接入编写实例

\#\# 本文件为 Shell 脚本，请使用 Shell 格式完成数据上报

\#\# 请使用脚本对指标和维度赋值



metric1=123 \# metric1, 指标

dimension1=abc \# dimension1, 维度

\#\# time=123 \# 自定义时间，默认使用上报时间



\#\# 将上述变量以 "Key Value"方式作为预置命令 （INSERT\_METRIC,INSERT\_DIMENSION）的参数以上报数据

\#\# 上报参数说明 : INSERT\_METRIC 指标字段名 指标字段值 ;  INSERT\_DIMENSION 维度字段名 维度字段值 ; INSERT\_TIMESTAMP 时间戳 ; COMMIT 提交上报数据



INSERT\_METRIC metric1 ${metric1}

INSERT\_DIMENSION dimension1 ${dimension1}

\#\# INSERT\_TIMESTAMP ${time}

COMMIT





