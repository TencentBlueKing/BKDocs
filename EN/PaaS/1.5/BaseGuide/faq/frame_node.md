# Node Framework Usage Related

## What Processing Does PaaS Do When Deploying Node Applications?

The entire process of deploying Node applications on PaaS includes:

- Enabling a container (Docker) to initialize the service system (Ubuntu Linux)
- Checking for the existence of `bin/pre-compile` and executing the pre-compile hook
- Installing Node and npm environments according to the `engines` configuration in `package.json`
- Installing package dependencies based on `dependencies` and `devDependencies` in `package.json`
- Caching the `node_modules` directory; if `package.json` is not updated for the next deployment, use the cache directly
- Checking for `scripts.build` and executing `npm run build`
- Removing dependencies under `devDependencies`
- Checking for the existence of `bin/post-compile` and executing the post-compile hook
- Initializing the service based on the application description file's defined service entry [Application Process](../topics/paas/process_procfile.md)

## Besides Express, Which Other Node Frameworks Are Supported, Such as Koa, Egg, Nest?

Based on the deployment process above, mainstream Node frameworks are supported. You just need to write the dependencies of the framework you are using into `dependencies`, and the Node build tool will automatically help you initialize the entire application's runtime environment.

## What Built-in Environment Variables Does the PaaS Platform Have?

Please refer to the document: [Built-in Environment Variables](../topics/paas/builtin_configvars.md)

## How to Set and Get Environment Variables in Node Frontend Frameworks

Add environment variable entries:

- Cloud Native Applications: 'Module Configuration' - 'Environment Variables'
- Regular Applications: 'Application Engine' - 'Environment Configuration'

In the code, get the corresponding values through the global object `process`

```javascript
// Get the application's app_code
const appCode = process.env.BKPAAS_APP_ID
// Get custom environment variables
const myKey = process.env.myKey
```

## What Hooks Are Provided When Deploying Node Services?

During the deployment process of Node applications, corresponding hooks are provided to facilitate developer intervention for custom processing, including:

- pre-compile: Executed by the build tool before installing Node
- post-compile: Executed by the build tool after build

You only need to create shell scripts named `pre-compile` and `post-compile` and place them in the `bin` directory to execute automatically

For example, if you want to know the start and end times of the build to roughly estimate the total deployment time:

```bash
#!/bin/bash
# Display the current time
start_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "Start Time: ${start_time}"
```

## How to Configure the Node and NPM Versions to Be Used

Configure `package.json` and add `engines` information. The Node build tool will first check `engines` when installing Node and attempt to install according to the version specified in `engines.node`. If it is not successful, it will automatically install the default version.

Note: For expressions like ">= 10.10.0", PaaS will still only install version 10.10.0 and will not install a newer version, mainly because we currently do not provide a Node version detection mechanism.

```json
"engines": {
    "node": "10.10.0",
    "npm": "6.4.1"
  }
```

## About the Difference Between Dependencies and DevDependencies and Matters to Note During Deployment

After PaaS completes the installation of the Node environment, the next step is to execute `npm install` for dependency installation. At this point, the dependencies under `dependencies` and `devDependencies` will be installed one by one.

- `dependencies`: Officially defined as dependencies used in the production environment
- `devDependencies`: Officially defined as dependencies used only in the development environment

For example, if you need to use webpack to build your code, it is necessary when executing `npm run build`. However, when running the service, you only need the code built by webpack, and webpack itself is not necessary, so the dependency for webpack is placed in `devDependencies`.

Note: Dependencies under `devDependencies` will be automatically removed after the build process in PaaS. For example, if your dependency package needs to be used during service runtime, such as express, but is accidentally written in `devDependencies`, the service will report `module not found` when running.

## Will npm install Be Executed During Frontend Deployment?

During PaaS deployment, after the Node build tool installs dependencies, it will check if there is a `build` entry in the `scripts` of `package.json`. If so, it will automatically execute `npm run build` to build the project.

## How to Configure an Independent Domain and the IP Address Applied for the Domain

Application IP Query: Select the 'Access Management' page to view IP information

For details, see the document: [Application Access Entry Configuration](../topics/paas/app_entry_intro.md)

## Is the Default Deployment Port 5000 Adjustable?

The service defaults to using port 5000 mapped to 80. If your service port is not 5000, the deployment status will remain as deploying because PaaS will default to probing port 5000 to determine if the service has started. Therefore, if it is not port 5000, you need to configure it as follows:

Select 'Application Engine - Access Entry' settings page, configure 'Service Process Management', and redeploy immediately after adjustment.

## How to Determine Whether the Current Running Environment Is a Test Environment (Stag) or a Production Environment (Prod)

You can distinguish the current deployment environment through the system's built-in environment variable `BKPAAS_ENVIRONMENT`.

```javascript
const env = process.env.BKPAAS_ENVIRONMENT
if (env === "stag") {
  // Test environment
} else if (env === "prod") {
  // Production environment
}
```

## How to Perform Frontend and Backend Separation

For details, see the document: [How to Perform Frontend and Backend Separation Development](../topics/paas/multi_modules/separate_front_end_dev.md)

## BlueKing Unified Login Failed

It may be that the cookie is contaminated. You can try clearing the cache and then relogging in to refresh the page.

## How to Start a Node Service with Non-BlueKing Node Frameworks

The idea of the entire frontend web service is to use a Node service to run the built static resources. Therefore, you can first define a Node service

```javascript
const express = require("express")
const path = require("path")
const app = new express()
const PORT = 5000
// Homepage
app.get("/", (req, res) => {
  const index = path.join(__dirname, "./dist/index.html")
  res.render(index)
})
// Configure static resources
app.use("/", express.static(path.join(__dirname, "./dist")))
// Service startup
app.listen(PORT, () => {
  console.log(`App is running on port ${PORT}`)
})
```

Add a server entry to `package.json` scripts

```javascript
scripts: {
	server: node prod-server.js
}
```

Add the following content to the `app_desc.yaml` file:

```
spec_version: 2
module:
  language: Node.js
  processes:
    web:
      command: npm run server
```

## Deployment Failed, Encountering import Syntax SyntaxError: Unexpected Identifier Error How to Handle

When deploying directly using the Node framework provided by BlueKing, you may encounter the following error message

```bash
import path from 'path';
       ^^^^
SyntaxError: Unexpected identifier
    at new Script (vm.js:79:7)
    at createScript (vm.js:251:10)
    at Object.runInThisContext (vm.js:303:10)
```

Node version 8.5 and above have begun to support import, and Node version 10LTS has default support for ES6 modules, see github issue: [https://github.com/nodejs/node/pull/15308](https://github.com/nodejs/node/pull/15308)

Therefore, you can perform the following checks:

- Check whether the configuration files `.babelrc`, `.eslintrc.js` are submitted according to the framework template, especially under window, as starting with a dot will be set as a hidden file and not submitted successfully
- Check whether the Node version configured in `engines` in `package.json` is too low
- Check the runtime configuration selected in the environment configuration, choose Node + TNPM environment (default Node version is 10.10.0)

## npm Installation of Dependency Packages Failed

- Failure Prompt

```
npm ERR! code EINTEGRITY npm ERR! sha
```

Solution: When downloading npm packages, npm will perform a hash check on the package. Sometimes this problem occurs due to the mixing of different sources. Generally, you can delete `package-lock.json` to solve it.

- Failure Prompt:

```
npm ERR! ERESOLVE unable to resolve dependency tree
npm ERR! Could not resolve dependency
npm ERR! Fix the upstream dependency conflict, or retry
npm ERR! this command with --force, or --legacy-peer-deps
```

Solution: This prompt is often due to multiple modules depending on different versions of the same module, causing conflicts. Therefore, you can add version configuration for the conflicting module in `dependencies` or `devDependencies` in `package.json`.

## npm Installation of Dependency Packages Prompt No Matching Version Found

- Failure Prompt

```
npm ERR! notarget No matching version found
```

Solution:

1. Download the required package version to the local machine, and then upload it to bkrepo via command

Generally, Node.js SDKs have complex dependencies. If you need to add additional Node.js SDKs to bkrepo, you need to upload other SDKs that the SDK depends on to bkrepo.
For this purpose, the platform provides the Node.js dependency management tool bk-npm-mgr. This tool is integrated into the image paas3-npm-mgr, or it can be directly downloaded and installed from bkrepo (running dependency node >= 12).
The following explains how to use the bk-npm-mgr tool to upload additional Node.js SDKs to bkrepo.

```bash
# Execute the following operations on a machine that can access the external network.
# 1. Start the container
docker run -it --rm --entrypoint=bash ${your-docker-registry}/paas3-npm-mgr:${image-tag}
# 2. Install the additional Node.js SDK to be uploaded, taking vue as an example.
yarn add vue@3.0.11
# 3. Download dependencies to the dependencies directory (package.json file will be generated when executing step 2)
bk-npm-mgr download package.json -d dependencies
# 4. Upload Node.js SDKs in the dependencies directory to bkrepo
bk-npm-mgr upload --username ${your-bkrepo-username} --password ${your-bkrepo-username} --registry ${your-bkrepo-endpoint}/npm/bkpaas/npm -s dependencies -v

# If you need to upload a self-developed SDK to bkrepo, you need to mount the source code to the container, which can refer to the following process.
# 1. Start the container and mount the source code to the startup directory.
docker run -it --rm --entrypoint=bash -v ${NodeSDK source code absolute path}:/blueking ${your-docker-registry}/paas3-npm-mgr:${image-tag}
# 2. Download dependencies to the dependencies directory
bk-npm-mgr download package.json -d dependencies
# 3. Package the SDK to dependencies
yarn pack -f dependencies/${your-sdk-name.tgz}
# 4. Upload Node.js SDKs in the dependencies directory to bkrepo
bk-npm-mgr upload --username ${your-bkrepo-username} --password ${your-bkrepo-username} --registry ${your-bkrepo-endpoint}/npm/bkpaas/npm -s dependencies -v
```

2. If there is an external npm source, you can ask the operations team to modify `BUILDPACK_NODEJS_NPM_REGISTRY` to point to the external network and then restart the apiserver module.