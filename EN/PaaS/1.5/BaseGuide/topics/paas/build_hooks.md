# Build Phase Hooks

## What are Build Phase Hooks?

The platform provides three "hooks" that allow users to execute custom scripts when deploying a new version of an application. Two of these "hooks" are executed before and after the build phase, which we refer to as the pre-build command and the post-build command, respectively.

To better understand build phase hooks, let's first look at the deployment process.
The deployment process for building applications based on source code is divided into two phases:

- Build phase: Constructing a runnable image from the source code package
- Release phase: Deploying the image into application instances

Taking the BlueKing development framework as an example, the platform will install the necessary Python packages according to the `requirements.txt` file. However, there are some special cases:

- Some Python packages have dependencies on system libraries that need to be installed in advance to complete the final installation.
- Some operations need to be completed before the release phase, such as database changes.

Using build phase hooks can easily solve these problems.

## How to Use Build Phase Hooks?

The platform specifies that the `bin/pre-compile` and `bin/post-compile` files in the user's code are the custom scripts executed in the build phase hooks, where `pre-compile` defines the pre-build hook, and `post-compile` defines the post-build hook.

During the actual build phase, all environment variables can be used. (For more information about environment variables, see [How to Use Custom Environment Variables](./custom_configvars.md).)

If the build phase hooks fail to execute, the build will be considered a failure, and it will not proceed to the "deployment phase."

## Examples

### Example of a pre-compile script:

```bash
#!/bin/bash
npm config set registry https://mirrors.tencent.com/npm/
echo `npm config list`
```

This script will set the npm dependency source address before the "build" phase (i.e., before installing node dependencies), ensuring that the "build" phase uses this dependency source.

### Example of a post-compile script:

```bash
#!/bin/bash
echo "Post Hook: this runs after build"
```

{% include warning.html content="For the behavior of pre-compile and post-compile, please ensure that ***modifications to the file system*** are ultimately made within the ***project directory***, and that all operations use relative paths with the project directory as the root. Otherwise, they will not be built into the image." %}

## FAQ

### How to Ensure All Commands Declared in Build Phase Hooks Execute Successfully?

According to the execution rules of bash scripts, a script is considered failed only if the last command fails. If you want to stop execution at the first failed command, please add `set -e` at the beginning of the script, for example:

```bash
#!/bin/bash
set -e
python manage.py migrate --no-input
```

### How Can BlueKing Applications Based on Image Deployment Execute Custom Commands Before Release (Such as Database Changes)?

For BlueKing applications based on image deployment, please use [Pre-release Commands](./release_hooks.md).