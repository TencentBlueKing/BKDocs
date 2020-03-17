### 1. General introduction of the scheme.

In order to facilitate developers to use and utilize the existing environment configuration, the following scheme utilizes python's virtualenv module to create multiple independent python environments, and solves the problem of mutual independence between python2 and python3 development environments. At the same time, in order to reduce the threshold of using virtualenv, the virtualenv wrapper module is also used in the scheme, which is convenient for us to create, copy and delete each virtual environment.

![1543555724_8_w844_h418.png](../assets/python2_3-struct.png)

Of course, there are other solutions in python ecosystem, which you can use for reference:

- [pyenv](https://github.com/pyenv/pyenv)
- [pipenv](https://github.com/pypa/pipenv)

### 2. Install python3 & virtualenvwrapper.

【MacOS Environmental】

First, let's go to the python official website to download the latest python installation package：[Python download address](https://www.python.org/downloads/). It is strongly recommended that you use the installer to install. Because if you use the source installation, you will encounter openssl development dependent environment and macos system restrictions, which brings you a variety of troubles.

【Linux Environmental】

We suggest that you can use python source package for installation. The advantage of this is that we can specify python installation path to ensure that the newly installed python3 will not affect existing system tools, such as yum. Here, it is recommended that you use python3.6.3 source code installation, because the version of openssl will be limited after python3.7, but the version of openssl provided by the company's intranet Yum source does not meet the requirements, which will lead to the lack of openssl module during the installation of python3.7, thus affecting the use of pip.

The source installation command is as follows:

```
tar -zxf Python-3.6.3.tgz
cd Python-3.6.3
# The custom configuration installation path is /opt/python36
./configure --prefix=/opt/python36
# Compile and install
make -j 4
make install 
export PATH=/opt/python36/bin:$PATH
```

 【Windows Environmental】

When installing windows, you need to pay attention to using the custom installation path. Please refer to the following video: [windows installation instructions](https://www.youtube.com/watch?v=V_ACbv4329E). Please note that the path environment variable needs to be modified after installation.

【virtualevnwrapper install】

After the installation, you can find that you have added a 【python3】 command locally. Of course, don't worry about losing the system's own python2 environment. The installer will keep the python2. As shown in the figure below:

![1543556228_89_w1440_h628.png](../assets/python2_3-which.png)

Next, we need to install virtualenvwrapper to help us create a separate virtual environment. Windows users need to install virtualenvwrapper-win.

```
# Install virtualenvwrapper
# windows user note，install virtualwrapper-win
$ sudo pip install virtualenvwrapper
...
# Specifies the directory where the virtual environment is placed, which can be adjusted as needed
$ export WORKON_HOME=~/Envs
# Create a good path
$ mkdir -p $WORKON_HOME
# Add virtualenvwrapper command and environment preparation. It is recommended that this command can be placed in ~/.bash_profile
$ source /usr/local/bin/virtualenvwrapper.sh
```

###  3. Segmentation environment.

After installation, we can take a look at the help menu of virtualenv, as shown in the figure below：![1543626174_42_w1780_h1820.png](../assets/python2_3-option.png)

-p This parameter is the key to the implementation of the whole scheme. We can use this parameter to specify the path of the python interpreter used by the virtual environment. By default, the parameter uses the /usr/bin/python interpreter. Therefore, we can specify different interpreter paths and create different virtual environments for py2 and py3. The operation is as follows:

```
$ mkvirtualenv test_python2_env 
New python executable in /Users/.virtualenvs/test_python2_env/bin/python
Installing setuptools, pip, wheel...done.
virtualenvwrapper.user_scripts creating /Users/.virtualenvs/test_python2_env/bin/predeactivate
virtualenvwrapper.user_scripts creating /Users/.virtualenvs/test_python2_env/bin/postdeactivate
virtualenvwrapper.user_scripts creating /Users/.virtualenvs/test_python2_env/bin/preactivate
virtualenvwrapper.user_scripts creating /Users/.virtualenvs/test_python2_env/bin/postactivate
virtualenvwrapper.user_scripts creating /Users/.virtualenvs/test_python2_env/bin/get_env_details
(test_python2_env) $ python 
Python 2.7.10 (default, Aug 17 2018, 17:41:52) 
[GCC 4.2.1 Compatible Apple LLVM 10.0.0 (clang-1000.0.42)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> ^D
(test_python2_env) $ mkvirtualenv test_python3_env -p /usr/local/bin/python3
Running virtualenv with interpreter /usr/local/bin/python3
Using base prefix '/Library/Frameworks/Python.framework/Versions/3.6'
New python executable in /Users/.virtualenvs/test_python3_env/bin/python3
Also creating executable in /Users/.virtualenvs/test_python3_env/bin/python
Installing setuptools, pip, wheel...done.
virtualenvwrapper.user_scripts creating /Users/.virtualenvs/test_python3_env/bin/predeactivate
virtualenvwrapper.user_scripts creating /Users/.virtualenvs/test_python3_env/bin/postdeactivate
virtualenvwrapper.user_scripts creating /Users/.virtualenvs/test_python3_env/bin/preactivate
virtualenvwrapper.user_scripts creating /Users/.virtualenvs/test_python3_env/bin/postactivate
virtualenvwrapper.user_scripts creating /Users/.virtualenvs/test_python3_env/bin/get_env_details
(test_python3_env) $ python 
Python 3.6.6 (v3.6.6:4cf1f54eb7, Jun 26 2018, 19:50:54) 
[GCC 4.2.1 Compatible Apple LLVM 6.0 (clang-600.0.57)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> 
```

 In the above operation, we first create a virtual environment using the default python interpreter. After creation, we can see that the corresponding version is 2.7.x after entering python. Then, the author creates a virtual environment using the path of the specified python interpreter. After the creation, we can observe that the corresponding version is 3.6.x when entering python. At this point, two independent and non-interference py2 and py3 environments are created.
If you need to switch between different environments, use the work on command to switch.