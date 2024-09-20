# How to use branch expressions correctly

### Expression composition

1. Comparison operators

- | Support == , != , > , >= , < , <= , in , notin and other binary comparison operators | Binary operators | Meaning | Example |
     | ------------------------------------------------------------ | ---------- | ------------------------------------------------- | ---- |
     | ==                                                           | equals       | \${v1} == True 、\${v1} == 1 、"${v1}" == "hello" |      |
     | !=                                                           | Not equal to     | ${v1} != 1                                        |      |
     | >                                                            | greater than      | ${v1} > 1                                         |      |
     | <                                                            | less than       | ${v1} < 1                                         |      |
     | >=                                                           | greater than or equal to   | ${v1} >= 1                                        |      |
     | <=                                                           | less than or equal to   | ${v1} <= 1                                        |      |
     | in                                                           | contained in     | \${v1} in (1, 2) 、"${v1}" in ('a','b')           |      |
     | notin                                                        | not contained in   | ${v1} notin (1, 2)                                |      |

 2. Comparison factors on the left and right sides of the comparison Operation 

   - Support for Global Variables, such as ${int(key)} 
   - Support for handling Global Variables using built-in Function, datetime, re, hashlib, random, time, os.path module 
   - True/true, False/false as comparison factors 

 ### Expression Connection 

 - Support the simultaneous use of multiple Expression, with and, or Keywords connection 

 ### Example 

 - String comparison: "${key}" == "my string" 
 - ${int(key)} >= 3 
 - ${key} in (1,2,3) 
 - \${key} > 3 and ${key} < 10 

 ### Expression execute Logic 

 When execute to a Exclusive Gateway/Conditional Parallel Gateway, the execution engine Processing the result of each branch Expression to True or False. 

 - A Exclusive Gateway only execute branches that result in True, and only One branch is Allow to be True.  If there are multiple True Branch, the Exclusive Gateway reports an error 
 - The Conditional Parallel Gateway execute All Branch that result in True in parallel 

> Tips：

 - The conditional Exclusive Gateway can be used with a drop-down box var (single choice) to ensure that one and only One branch hits 
 - Conditional Parallel Gateway can be used with drop-down box var (multiple choices) to achieve multiple Branch hits 