# How to Export Data

## Preface

This guide is currently only applicable to Django applications. If other frameworks do not have similar data export commands, please contact BlueKing Assistant for details.

Other considerations:

- This method is only suitable for exporting **small amounts of data (<10MB)**. For larger data volumes, please contact BlueKing Assistant.
- If you only need to export certain tables instead of the entire database, please refer to the [django dumpdata documentation](https://docs.djangoproject.com/en/3.2/ref/django-admin/#dumpdata-app-label-app-label-app-label-model) to add parameters.
- Since `post_compile` is executed during the deployment process, the amount of data will affect the deployment speed. After completing the data export operation, please remember to restore the `post_compile` file.

## Specific Steps

### Step 0: Apply for Object Storage

Enhanced Services -> Object Storage -> Enable

### Step 1: Export in post_compile

As we all know, `post_compile` is essentially a bash script, so we can write the export logic directly into it, example:

```bash
# export logic start

# export via django commands
# refer to https://docs.djangoproject.com/en/3.2/ref/django-admin/#dumpdata-app-label-app-label-app-label-model
python manage.py dumpdata > dumps.json

# upload to s3
s3cmd put dumps.json --host $CEPH_RGW_HOST --secret_key $CEPH_AWS_SECRET_ACCESS_KEY --access_key $CEPH_AWS_ACCESS_KEY_ID --acl-public s3://$CEPH_BUCKET
```

### Step 2: Download from Object Storage

Assuming the example above is for an internal version, and CEPH_BUCKET is `bkapp-test-stag`.

### Step 3: Add to Version Control and Import to Other Environments (Optional)

If you also need to import this data into other environments, such as stag -> prod or prod -> stag, then you need to add this json file to the **root directory** of the version control repository, and add import logic during post_compile

```bash
python manage.py loaddata dumps.json
```

## Notes

After using the data, remember to delete the data from ceph using s3cmd