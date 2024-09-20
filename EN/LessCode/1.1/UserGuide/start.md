## Get started quickly

## 1. Create application

After entering the BlueKing LessCode, you can "Create Application" to start online one-stop research and development.


<img src="./images/create-proj.png" alt="grid" width="540" class="help-img">

Notice:

1. The application ID will be used as the prefix of the custom component ID of the application. Please name it carefully.

2. When creating an application, you can choose to initialize the navigation layout instance, and create application pages based on the specified navigation layout instance.

3. The platform will automatically create a demo application for users who use the platform for the first time, named "username + Demo application"

4. When the creation is successful, the default module of the saas application with the same name will be created simultaneously in the PaaS platform-Developer Center and bound to the LessCode application. After subsequent drag and drop is completed, it can be directly deployed to the bound saas application.


## 2. Create\edit page

Enter the application "Page List", you can create multiple pages and edit the page layout by dragging and dropping.

- Select the layout navigation style used by the page

<img src="./images/create-page.png" alt="grid" width="540" class="help-img">

- Drag components to the canvas area to configure

<img src="./images/page1.png" alt="grid" width="540" class="help-img">

### 2.1 Component selection area

- Basic components: Contains basic common PC-side components provided by the BlueKing Vue component library
- Custom components: including custom components uploaded within the current application and custom components exposed by other applications

### 2.2 Canvas area
- Step 1: Drag the component "Fence Layout" or "Free Layout" into the canvas, such as "Multiple Column Component" Fence Layout

     <img src="./images/page2.png" alt="grid" width="540" class="help-img">

- Step 2: Drag other components into the "Multiple Column Components" fence layout and free layout

     <img src="./images/page3.png" alt="grid" width="540" class="help-img">

- Step 3: Edit component styles, properties, and bind event functions

- Step 4: Configure page navigation

     <img src="./images/page11.png" alt="grid" width="540" class="help-img">

- Step 5: Preview and save the page

## 3. Function management
You can create and manage the JS functions needed for application pages. The platform provides two sample functions for reference.
- getMockData: Based on the blank function template, obtain the remote API to obtain Mock data
- getApiData: Based on the remote function template, fill in the remote API call information. The function itself only processes the data returned by the remote API.

Functions can be used for component event binding or component data source acquisition.

### Notice
- The remote API called in the function can be the API provided by any system, such as the API provided by the BlueKing SaaS you developed, or the cloud API provided by BlueKing APIGateway
- When calling the remote API in a function, you may encounter cross-domain issues and API permission verification issues. Please make the call according to the remote API requirements.


## 4. Custom component management
In the page editing component selection area, in addition to the basic common components provided by BlueKing, you can also upload your own developed business scenario components.

Notice:
- Component development must follow the custom component specifications provided by the platform
- The "type" attribute in the component configuration (config.json) must be prefixed with "Application ID", that is: Application ID-xxx
- The component upload package must be packaged using the packaging tool provided by the platform and then uploaded.

## 5. Release and deployment


   When creating the LessCode application, the BlueKing Developer Center application module has been created simultaneously. After the application page editing is completed, it can be directly published and deployed to the BlueKing PaaS platform.

- You can directly select the environment and version that need to be deployed for deployment

     <img src="./images/page8.png" alt="grid" width="540" class="help-img">

## 6. Secondary development
If you need to perform secondary development on the drag-and-drop page, you can refer to the following methods:

### Method 1: Download all source codes of the application
The platform will integrate all page source codes and page routing configurations of the application into the BlueKing front-end development framework (BKUI-CLI) framework. The downloaded source code package can be deployed directly in the PaaS platform-Developer Center.

<img src="./images/page5.png" alt="grid" width="540" class="help-img">

### Method 2: Download the source code of a single page
If it is an application under development, you only need to drag and drop a separate page for secondary development. You can only download the source code of a single page and put it into the project code of your existing application under development.

<img src="./images/page6.png" alt="grid" width="540" class="help-img">