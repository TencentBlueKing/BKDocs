# 添加阶段 stages

## 关键字 stages

定义一个或多个 stage 
值格式为：Array<Stage>，多个 stage 组成的数组

### 多个stage

配置示例：
	
##### 多个stage多个job


 ```
version: v3.0

stages:
- name: "stage1"
  jobs:
    job_id_1:
      name: my_job_1
      steps:
      - run: |
          echo "stage1, job_id_1"
    job_id_2:
      name: my_job_2
      steps:
      - run: |
          echo "stage1, job_id_2"
- name: "stage2"
  jobs:
    job_id_3:
      name: my_job_3
      steps:
      - run: echo "stage2, job_id_3"
```

	
### 单个stage支持简写

支持简写，可以省略 stages 关键字，如：
	
#### 流水线中仅有多个 job 组成的一个 stage

##### 仅有一个stage，stage配置缺省，有一个或多个job


 ```
version: v3.0

jobs:
  job_id_1:
    name: my_job_1
    steps:
    - run: |
        echo "stage1, job_id_1"
  job_id_2:
    name: my_job_2
    steps:
    - run: |
        echo "stage1, job_id_2"
```

	
#### 流水线中仅有多个 step 组成的一个 job

##### 仅有一个stage且仅有一个job，stage、job配置全用缺省值


 ```
version: v3.0

steps:
- run: |
    echo "stage1, job_id_1"
    echo "hello world!" >> test.txt
- uses: UploadArtifactory@1.*
  with:
    path: test.txt
```