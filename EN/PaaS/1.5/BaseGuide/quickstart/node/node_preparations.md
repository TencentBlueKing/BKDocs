# Developing Node.js Applications

This article will introduce how to develop a Node.js application on the BlueKing Developer Center. After completing this tutorial, you will understand:

- Basic concepts of the BlueKing Developer Center: BlueKing applications, application deployment, etc.
- How to develop a simple Node.js BlueKing application
- How to use the Node.js development framework

To successfully complete the tutorial, you need:

- Basic understanding of JavaScript syntax
- Basic understanding of the Node.js Express framework

The BlueKing Node.js development framework uses Express as the development framework and integrates with BlueKing's unified login.

> New to Node.js? We recommend learning Node.js from the [official Node.js documentation](https://nodejs.org/zh-cn/docs/) and [Express official documentation](https://expressjs.com/zh-cn/).

## Preparations

#### Create a Node.js Application

Before starting the tutorial, you need to create a BlueKing application using the `Node.js development framework` through the 'Application Development - Create Application' page on the BlueKing Developer Center.

After the application is created successfully, follow the instructions on the page to clone the development framework code to your local machine.

## Development Environment Configuration

Before starting application development, you need to install Node.js and the third-party modules required by the BlueKing application on your machine. The environment configuration method may vary slightly depending on the operating system you are using. Please follow the instructions for your operating system.

In the `package.json` file in the project build directory (default is the root directory if not set), check the versions of Node.js and NPM used by the project.

```json
"engines": {
    "node": ">= 16.16.0",
    "npm": ">= 6.4.1"
}
```

You can also configure the versions of the dependency packages according to your project requirements and modify the **package.json**.

### 1. Install Node.js

Visit the [official Node.js download page](https://nodejs.org/zh-cn/download/) and download the version of Node.js you need.

After installation, verify the installation by entering the `node -v` command in the command line:

```bash
v16.16.0
```

### 2. Install Package Manager NPM

npm makes it convenient to manage your project's dependencies. npm is installed by default when you install Node.js. You can verify the installation by entering the `npm -v` command in the command line:

```bash
6.11.3
```

### 4. Install Dependencies

Enter the build directory (default is the root directory if not set) and execute the command **npm install** to install dependencies. After successful installation, a node_modules directory will be created.

### 5. Complete Development Environment Configuration

Congratulations! If you haven't encountered any problems with the above installations, then your development environment is ready.

## Running the Project

After the environment configuration is completed, we still need to make some additional configurations to get the project running smoothly.

### Configure hosts

First, you need to configure the hosts file locally and add the following content:

```bash
127.0.0.1 dev.xxx.xxx (Note: must be on the same first-level domain as the PaaS platform main station)
```

### Start the Project Locally

Execute the following command in the project build directory (default is the root directory if not set):

```shell
npm run start
```

Then visit http://dev.xxx.xxx:5000 in your browser to see the homepage of the project.

## Developing a Page

### 1. Create a New View Template

Add your template db.ejs to the views folder:

```html
<ul>
  <% results.forEach(function(r) { %>
  <li><%= r.id %> - <%= r.name %></li>
  <% }); %>
</ul>
```

### 2. Set Up Routes

Add your route to index.js:

```bash
app.get('/db', function(request, response) {
    response.render('pages/db', {
        'SITE_URL': process.env.BKPAAS_SUB_PATH,
        'results': [
            {
                id: '1',
                name: 'test1'
            }
        ]
    });
});
```

### 3. Restart the Project

Restart the project and visit http://dev.xxx.xxx:5000/db to see your new page and rendered data.

## Publishing Applications

### Deploying Applications

For information on deploying applications, you can read more in [How to Deploy BlueKing Applications](../../topics/paas/deploy_intro.md).

### Publish to the Application Market

Before deploying to the production environment, you need to:

- Improve your market information in 'APP Promotion' - 'Market'
- Deploy to the production environment

Then you can find your application directly in the application market.