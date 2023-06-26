## Q1: Merge-Request-Accept-Hook

![](../../../../assets/image-20220301101202-RtEPQ.png)

Merge Request Accept Hook会在源分支**成功merge到目标分支时触发**

比如，需要将feat\_1合并到dev分支时，分支名称写dev，监听源分支写feat\_1（也可以使用\*号的模糊匹配功能，如feat\_\*）

![](../../../../assets/image-20220301101202-pxOZb.png)



## Q2: gitlab触发器在哪里配置webhook地址

不需要配置这个hook，BKCI是会自己注册webhook，选择事件类型后保存，就会自动注册webhook

![](../../../../assets/wecom-temp-d5c48ee99a96d373426491d14d56e404.png)



## Q3: 有条流水线通过gitlab提交触发了，但查看代码变更记录为空。说明此次触发的构建，并没有新代码变更，却仍然触发了流水线

可能的原因是，触发器监听了整个代码库的commit事件，但代码拉取插件只拉取了某一个特定分支的代码，而此分支并没有代码变更，比如，插件监听了整个代码库commit事件，但代码拉取插件只拉取了master分支的代码，而提交commit的是dev分支，代码变更记录显示的是所拉取的分支相交上一次体检的变更，master分支没有变更，所以没有变更记录。



## Q4: 提pr时想触发流水线应该如何配置

如果是使用gitlab托管代码，直接配置gitlab触发器，触发的事件类型有：

1. Commit Push Hook 代码提交时触发
2. Tag Push Hook 提交有tag的代码时触发
3. Merge Request Hook 当有代码合并时触发
4. Merge Request Accept Hook 当代码合并后触发



## Q5: 监听和排除有优先级吗？

监听 > 排除

假设 trigger 既配置了监听选项，又配置了排除选项，且事件中既包含监听又包含排除，那么将会触发该流水线。



## Q6:监听的路径可以进行通配吗？

不支持通配符功能。目前可以支持前缀匹配功能。

例如在监听目录中填写 source，而 sourceabc 目录进行了变更，也会监听到该事件。



## Q7:配置了监听路径，但生成的 trigger 为监听根目录

符合预期。服务端是监听根目录的，但是BKCI会根据这个路径来做过滤。

这个触发器是针对的BKCI，BKCI也会根据配置的监听路径做过滤，决定是否触发流水线。

如果是只想局限到某个路径下的话，需要手动改一下。
