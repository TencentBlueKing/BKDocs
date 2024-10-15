# How to make datadog plug-in online

It is very convenient to create a plug-in in the plug-in management of the monitoring platform.

## Step 1: Preparation

1. Get BK-Plugin Framework

    ```bash
    git clone https://xxx.com/datadog_plugin_framework.git
    ```

2. Get Integrations (6.15x branch code)

    official

    ```bash
    git clone https://github.com/DataDog/integrations-core.git
    ```

    Community

    ```bash
    git clone https://github.com/DataDog/integrations-extras.git
    ```

    Clone the above warehouse to see if there are required components. If not, you need to develop it yourself according to [official specifications](https://docs.datadoghq.com/developers/integrations/new_check_howto/). Each Integrations package is a complete Python package that contains the collection logic of a component.

3. Prepare two operating systems and make sure `python 2.7` and `pip` are installed

    - Windows 64 bit
    - Mac OS/Linux 64-bit

## Step 3: Generate basic package

Take the `consul` component as an example

1. Find the folder named `consul` in the local `integrations-core` repository and record the path

    ```bash
    ~/Projects/integrations-core/consul
    ```

2. Enter the `datadog_plugin_framework` directory and execute the build command

    ```bash
    python build.py consul ~/Projects/integrations-core/consul -o ~/Desktop/datadog_plugins
    ```

    After a while, a folder named `bkplugin_consul` will be created under the path `~/Desktop/datadog_plugins`. Depending on the operating system you are using, a directory corresponding to os will be generated.

3. Compress the generated `bkplugin_consul` directory into `tgz` format, and then upload it on the plug-in editing page

## Step 3: Create a plug-in in plug-in management