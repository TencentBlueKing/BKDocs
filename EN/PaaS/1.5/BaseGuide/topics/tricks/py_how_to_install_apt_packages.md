# How to Install Linux System-Level Dependency Packages

In BlueKing applications, if your application needs to install third-party libraries that depend on Linux system-level software packages (such as mysql-dev, etc.), you can add an Aptfile to the repository to drive the platform to complete the software package installation during the build phase.

## Aptfile

Users need to use an _Aptfile_ in the application build directory (default to the root directory if not set) to describe the packages that need to be installed, with each dependency on a separate line:

```
libssl-dev
```

This is equivalent to:

```bash
apt-get install -y libssl-dev
```

You can also specify a URL to download and install, but since safety cannot be guaranteed, do not casually install untrusted packages. Similarly, each dependency is on a separate line:

```
http://radosgw.example.com/paas-assets/buildpacks/apt/deb-packages/z-libc-bp-fix.deb
```

This is equivalent to:

```bash
wget http://radosgw.example.com/paas-assets/buildpacks/apt/deb-packages/z-libc-bp-fix.deb
dpkg -i z-libc-bp-fix.deb
```

The above dependencies written into an _Aptfile_ should look like this:

```
libssl-dev
http://radosgw.example.com/paas-assets/buildpacks/apt/deb-packages/z-libc-bp-fix.deb
```

### Installing libmysqlclient-dev

Add the following content to the Aptfile:

```
http://radosgw.example.com/paas-assets/buildpacks/apt/deb-packages/z-libc-bp-fix.deb
libssl-dev
libc6-dev
default-libmysqlclient-dev
```

## Using Apt Build Tools

BlueKing applications support multiple build tool base images and corresponding build tools for _installing system packages_.

**Build tools are built one by one, so pay attention to the order of build tool selection**. For example, to use apt-installed system dependencies during Python builds, installing system packages must be done before the Python environment:

Additionally, there may be differences between build and deployment paths, so do not use absolute paths with apt installation commands. The Apt build tool will ensure the accuracy of the system variable `PATH`.

## How to Debug Aptfile

Often, we cannot determine all dependencies at once, and repeatedly pushing code for deployment can be time-consuming and labor-intensive. Here is a method for simulating the online environment locally.

1. Pull the image using docker: `heroku/heroku:18` ;
2. Start the debugging container:

```shell
docker run --rm -ti heroku/heroku:18 bash
```

3. Install the required dependencies in the container to ensure the environment is correct:

```shell
apt-get update
apt-get install my-requirement
```

4. Write the dependencies to the Aptfile:

```
my-requirement
```

### How to Determine Missing Dependencies

Generally, we can determine the dependencies needed in advance through dependency documentation or online searches. However, due to the complexity of dependencies, we often only discover missing dependencies after encountering errors, such as the following error:

> libcrypto.so.10: cannot open shared object file: No such file or directory

So, how do we determine which dependency provides this file?

1. Pull the image using docker: `heroku/heroku:18` ;
2. Start the debugging container:

```shell
docker run --rm -ti heroku/heroku:18 bash
```

3. Install the dependency file search command `apt-file`:

```shell
apt-get update
apt-get install -y apt-file
```

4. Search for the required file:

```shell
$ apt-file find libcrypto.so
android-libboringssl: /usr/lib/x86_64-linux-gnu/android/libcrypto.so.0
android-libboringssl-dev: /usr/lib/x86_64-linux-gnu/android/libcrypto.so
libssl-dev: /usr/lib/x86_64-linux-gnu/libcrypto.so
libssl1.0-dev: /usr/lib/x86_64-linux-gnu/libcrypto.so
libssl1.0.0: /usr/lib/x86_64-linux-gnu/libcrypto.so.1.0.0
libssl1.1: /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1
```

Note that `apt-file` will list all dependencies containing the specified file, but this does not mean that all dependencies are available, so it is best to install them one by one to confirm the final required dependencies.

## Why Can't Hook Commands Be Used to Install Dependency Packages?

Some applications attempt to install packages during `pre-compile` or `post-compile`:

```bash
apt-get install -y some-package
```

Packages installed in this way are only effective in the temporary container used for building and cannot persist into the environment after the process starts.