# Pipeline失败的问题定位


## 关键词：问题定位、可视化、人力节省

## 业务挑战

当流水线失败报错时，开发团队需要对整个Pipeline进行梳理定位问题，耗费了开发人力。

## BKCI优势

通过BKCI的“TJS”（Task、Job、Stage）结构，复杂的流水线能够通过拖拽、点击等可视化操作构建。借助任务项（Task）执行状态的“红色”标识，团队能够快速直观定位流水线失败问题，以及获取执行日志，减少了工程师们在问题定位及排查环节上的人力投入。

## 解决方案

如果编译失败，只需检查执行状态显示“红色”标识的Task，不用检查全部编译过程；

![&#x56FE;1](../../../assets/scene-pipeline-failure-location-a.png)

点击“红色”区域后，进入日志详情页，查看错误日志。

![&#x56FE;1](../../../assets/scene-pipeline-failure-location-b.png)