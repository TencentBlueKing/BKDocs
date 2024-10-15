 # Using var in Shell/Batchscript/RunScript Plugin 

 ## Using var in Shell/RunScript Plugin 

 ```shell 
 # cd to Workspace 
cd $WORKSPACE

# echo "::set-variable name=<var_name>::<value>"
# eg:
echo "::set-variable name=version:1.0.0"
```

 set-variable takes Take Effect at the end of the current task, which cannot be printed in the current shell. 

```shell
# Reference version in subsequent shell Plugin 
echo ${{ variables.version }}
```

 ## Using var in Batchscript Plugin 

 ```bat 
 REM refers to the Global Variables WORKSPACE 
 cd %WORKSPACE% 

 echo "::set-variable name=FILENAME:a.zip" 

 ``` 

 Reference FILENAME in subsequent Batchscript Plugin 
 ```bat 
 echo on 
 echo ${{ variables.FILENAME }} 
 ``` 
