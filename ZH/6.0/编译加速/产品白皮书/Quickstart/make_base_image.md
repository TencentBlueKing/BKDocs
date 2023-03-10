# 制作基础编译环境镜像

## 1 linux gcc/g++镜像

基于系统镜像，在其基础上安装其他gcc版本。分为几个子步骤：

### 1.1 下载gcc源码包和基础系统镜像
在[https://ftp.gnu.org/gnu/gcc/](https://ftp.gnu.org/gnu/gcc/)找到需要的gcc源码tar包，下载并放到母机的/data/mount目录下
从dockerhub或其他途径，拿到需要的基础系统镜像，这里以centos7为例。

### 1.2 拉起构建容器环境

运行docker run拉起centos7镜像，将母机上的目录挂载进去

```bash
docker run -it -v /data/mounter:/data/mounter centos7:latest
```

### 1.3 编译安装目标gcc版本

将gcc源码包拷贝到容器目录下，解压后进入包的根目录

执行configure
```bash
./configure --prefix=/usr/local/gcc --enable-bootstrap  --enable-checking=release --enable-languages=c,c++ --disable-multilib
```

执行编译并安装
```bash
make -j && make install
```

修改环境变量

```bash
vi /etc/profile.d/gcc.sh
```
写入以下内容

```bash
export PATH=/usr/local/gcc/bin:$PATH
```

保存后执行
```bash
source /etc/profile.d/gcc.sh
```
导出头文件
       
```bash
ln -sv /usr/local/gcc/include/ /usr/include/gcc
```
导出库文件
```bash
vi /etc/ld.so.conf.d/gcc.conf
```
写入以下内容并保存
```bash
/usr/local/gcc/lib64
```

建立软链
```bash
ln -sf /usr/local/gcc/bin/gcc /usr/bin/gcc
ln -sf /usr/local/gcc/bin/g++ /usr/bin/g++
ln -sf /usr/bin/gcc /usr/bin/cc
```

### 1.4 保存成新的镜像

删除容器中多余的文件，如解压的gcc源码包等，防止目标镜像过大

在另一个会话中找到当前的容器

```bash
docker ps
```

然后将其commit成一个新的容器

```bash
docker commit xxxx tag
```

这样就得到了一个带有目标gcc版本的基础容器环境

### 1.5 错误处理

#### 1.5.1 执行configure期间报错
```bash
configure: error: Building GCC requires GMP 4.2+, MPFR 3.1.0+ and MPC 0.8.0+
```

则执行
```bash
yum install libmpc-devel -y
```
再重新configure即可