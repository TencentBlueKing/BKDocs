# Migration Related to Old Versions of Applications

### How to manage files after APP migration?

You can use the BlueKing object storage Add-ons.

For Django, we have a packaged SDK. For non-Django applications, you can use s3cmd to access it. For details, refer to [Using s3cmd to Access BlueKing Object Storage Service](../sdk/bkstorages/index.md)

### Can an old application that uses an external DB be migrated with one click?

The current process does not support one-click migration of external DBs and requires manual intervention.