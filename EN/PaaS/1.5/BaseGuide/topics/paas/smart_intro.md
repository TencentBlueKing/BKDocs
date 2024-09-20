# Characteristics of S-mart Applications

S-mart applications are a special type of application whose structure consists of a compressed package containing source code and an application description file. Developers can create and update application versions by uploading this compressed package to the Developer Center. Compared to traditional applications, S-mart applications have the following unique characteristics:

### Operational Restrictions on Add-ons

The add-ons for S-mart applications must be declared in the application description file `app_desc.yaml`. To prevent user misoperations, this application does not support enabling or disabling add-ons on the product page. If you need to modify the credentials for S-mart application add-ons, please refer to [How to Modify Add-on Environment Variables](./custom_configvars.md).

### Fixedness of Name and Market Information

The name and market information of S-mart applications can only be defined in the `app_desc.yaml` file and cannot be modified on the product page. This ensures the consistency and accuracy of the application's basic information at the time of upload.

### Restrictions on Module Definition

The modules of S-MART applications can only be defined in the `app_desc.yaml` file, and users cannot add new modules on the platform. This restriction fixes the application's structure at the time of upload, avoiding the complexity brought by dynamic changes.

### Handling of Static Resource Collection

For Python applications deployed via source code, the command `python manage.py collectstatic --noinput` is automatically executed during the build process to collect static resources.

The build and deployment processes of S-mart applications are separated. The image is built in advance through the pipeline, and there is no runtime information such as environment variables during the build process. For most applications, executing `python manage.py collectstatic --no.input` at this time will result in an error, so S-mart does not execute this command during the build process.

If the application depends on these static resources, you need to manually write this command into the application's startup command to ensure the correct handling of static resources.

### Summary

The design of S-mart applications aims to provide a simplified application management method, while also limiting certain flexibilities to ensure the standardization and stability of the applications. Developers using S-mart applications need to pay special attention to the configuration of the application description file to ensure that all settings meet expectations.