# 【试用】mac下C/C++基于hook的编译加速

**1. 将构建机的SIP保护禁掉**

由于编译加速过程中需要hook编译子进程，所以需要去掉SIP保护。

由devcloud提供的机器，可能默认已经去掉了SIP保护，可以通过命令： csrutil status 查看，如图所示：

![1](../../../assets/image2022-6-15_10-13-15.png)

如果SIP是开启的，可以按下面的链接进行操作：

https://developer.apple.com/documentation/security/disabling_and_enabling_system_integrity_protection



**2. 拷贝工具包并设置权限**

将工具包（附件）下载并拷贝到合适的路径，并为工具目录下文件添加权限(chmod +rx *)

mac系统默认有安全限制，为了确保加速工具能够正常执行，建议在finder中，找到加速工具所在目录，鼠标双击每一个加速工具程序，确保能够正常拉起
![2](../../../assets/image2022-6-15_10-20-39.png)


可以通过 mac->系统偏好设置->安全性与隐私来设置，如下图所示（有些会直接显示是否允许当前进程的执行）

![3](../../../assets/image2022-6-15_10-21-19.png)



**3. 修改工具包中的配置文件**

修改 bk_cc_rules.json， 将 bk-dist-executor 的路径改成工具所在路径
修改 clang_toolchain.json ，将clang的路径替换为项目编译中使用的clang的路径
a. 如果项目中指定了clang的绝对路径，则直接用该路径
b. 如果没有指定，用 xcrun -find clang 找到默认路径



**4. 适配编译脚本（命令）**

假设原始编译脚本为：
sh build.sh

则加速脚本修改为（将原始命令作为bk-booster的-a的参数）：

bk_tools=/path/to/bk_tools
echo \$bk_tools
export PATH=${bk_tools}:\$PATH # add path of tools to PATH

export no_proxy=.xxx.com,$no_proxy    #在devcloud提供的环境下，需要设置这个，避免访问不了加速server

bk-booster -bt cc -p 629da5ea2904d72ca77aed69 -a "sh build.sh" --hook --hook_preload_library "\${bk_tools}/bkhook.so" --hook_config "\${bk_tools}/bk_cc_rules.json" --tool_chain_json_file "${bk_tools}/clang_toolchain.json"



