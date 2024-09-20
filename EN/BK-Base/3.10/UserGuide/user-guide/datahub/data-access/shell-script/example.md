# Script access writing example

\#\# This file is a Shell script. Please use Shell format to complete data reporting.

\#\# Please use scripts to assign values to indicators and dimensions.



metric1=123 \# metric1, indicator

dimension1=abc \# dimension1, dimension

\#\# time=123 \# Customize time, use reported time by default



\#\# Use the above variables in "Key Value" mode as parameters of preset commands (INSERT\_METRIC,INSERT\_DIMENSION) to report data

\#\# Description of reporting parameters: INSERT\_METRIC indicator field name indicator field value; INSERT\_DIMENSION dimension field name dimension field value; INSERT\_TIMESTAMP timestamp; COMMIT submits the reported data



INSERT\_METRIC metric1 ${metric1}

INSERT\_DIMENSION dimension1 ${dimension1}

\#\# INSERT\_TIMESTAMP ${time}

COMMIT