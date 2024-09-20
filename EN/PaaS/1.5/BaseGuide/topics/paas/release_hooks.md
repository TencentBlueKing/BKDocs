# Pre-release Command

## What is a Pre-release Command?

The platform provides three "hooks" that allow users to execute custom scripts when deploying a new version of an application. The "hook" that is executed before the deployment (Release) phase is referred to as a pre-release command.

To better understand pre-release commands, let's first look at the deployment process.
The deployment process for building an application from source code is divided into two phases:

- Build phase: constructing an image from the source code package
- Release phase: deploying the application instance from the image

Taking a Django application as an example, Django uses migrations to declare the history of database changes. If multiple processes execute the `migrate` operation at the same time at some point, the state of the database at that time is unpredictable. Therefore, the platform provides pre-release commands for tasks with the following characteristics:

- Need to be completed before the release phase, such as database changes
- Cannot be executed concurrently

Pre-release Command Rules:

- The "pre-release command" cannot start with `start`
- The "pre-release command" can only be a single executable command
- The "pre-release command" must ensure that the first argument exists and has executable permissions

## Example

```bash
python manage.py migrate --no-input
```

This command will be executed before the release phase to ensure that process instances access the latest database structure.

**Note**: The platform executes the pre-release command by starting an independent container. After execution, the container will be destroyed, so any changes to the container files made by the command will not be synchronized to the final running container.

## How to Define a Pre-release Command?

1. For applications deployed using images, configure directly on the product page.

Entry point: 'Module Configuration' - 'Process Configuration'

2. For ordinary applications and cloud-native applications deployed using source code, define in the application description file `app_desc.yaml` at `module.scripts.pre_release_hook`, such as:

```
spec_version: 2
module:
  language: Python
  scripts:
    pre_release_hook: "python manage.py migrate --no-input"
  processes:
	# ...omitted
```

**Note**: If using an older version of the development framework and there is no `app_desc.yaml` file in the code repository, you can also place the command in the `bin/post-compile` file to perform some pre-release operations. The difference between them is explained in the FAQ below.

## FAQ

### What is the difference from the post-build command?

1. Different execution environments
   The "post-build command" runs in the build container and is executed immediately after the application build is successful, such as operating on temporary files generated during the build process.
   The "pre-release command" runs in an independent container, consistent with the container environment of the release phase.

2. Different definition rules
   The "post-build command" is defined in the user code's `bin/post-compile` file.
   The "pre-release command" is unrelated to user code and can be configured by developers in the platform's "Deployment Configuration".

> Note: The deployment process for applications deployed based on images only has a release phase.

### How to execute multiple commands?

Generally speaking, the "pre-release command" can only be a single executable command, but this does not mean that only one command can be executed.

#### Simple commands

For multiple simple commands, you can use `bash -c` as a guide, for example:

```bash
bash -c "cd backend && python manage.py migrate --no-input"
```

The above command will change the working directory to backend and then execute the migrate operation.

#### Complex commands

For complex commands, to avoid problems caused by character escaping and environment variable rendering, it is recommended to create a script in the user code (such as `bin/pre-release`) to encapsulate the corresponding commands, for example:

1. Configure the "pre-release command" as `./bin/pre-release`

2. Create a `bin/pre-release` file in the user code and grant executable permissions (refer to: chmod +x bin/pre-release)

```bash
#!/bin/bash
set -e
pip install s3cmd==2.0.0

cat >> ~/.s3cfg <<EOF
# Setup endpoint

host_base = ${CEPH_RGW_HOST}
host_bucket = ${CEPH_RGW_HOST}
bucket_location = us-east-1
use_https = False

# Setup access keys
access_key = ${CEPH_AWS_ACCESS_KEY_ID}
secret_key = ${CEPH_AWS_SECRET_ACCESS_KEY}

# Enable S3 v4 signature APIs
signature_v2 = False
EOF

s3cmd put ...
```

The above command can use the s3cmd command to upload static files to the object storage service, achieving static resource hosting.