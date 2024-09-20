# Platform Functionality Related

## Why Some Processes Cannot Use the "Access Console" Feature

Currently, the platform only opens the access console feature for applications that use the latest images. To use this feature, you need to:

1. In "APP Engine" → "Env Configs" → "Modify Runtime Configuration", select the base image: "BlueKing Base Image"

**Note**: After switching the base image, the build tool also needs to be reselected.

2. Redeploy to ensure that the process is deployed on the latest image.