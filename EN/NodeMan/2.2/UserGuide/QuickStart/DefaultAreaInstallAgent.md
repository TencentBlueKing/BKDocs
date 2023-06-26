# Install BlueKing Agent (direct mode)

## Step 1: Confirm the access point Configuration

Click "Global Setting" to confirm that the following configurations of the default access point are not blank, and the target CVM where the BlueKing Agent will be installed can connect to the private network addresses of these configurations.

![-w2020](media/20200604152835.png)

## Step 2: Install Agent remotely

Switch to the Agent Manage page and click the Install Agent button.

![-w2020](media/20200604153148.png)

To install a Business Name, select a service that has been created on the Configuration System. If there is no service, you can select Resource Pool.

Select "direct mode" for the cloud area, and use the default access point.

Then complete the target Host details Configuration for the install. When complete, click Install to begin the installation checks.

![-w2020](media/20200604153241.png)

## Step 3: Check the Implementation Status

After Step 2 is complete, you will automatically jump to the checks page and wait for the success Agent install. If the checks fail, you can click on the host to view the install log.

![-w2020](media/20200604153623.png)