## Custom component development guidelines

### npm installs custom component packaging and building tools

```bash
npm i -g @blueking/lesscode-cli
```

### Custom component project file structure

[Download demo sample package](https://staticfile.qq.com/lesscode/p9508f3d3cfba4809b2e1a3cba58cdd20/template-imgs/latest/bk-lesscode-component-vue2.zip)

```bash
|-- ROOT/ # Custom component root directory
     |-- config.json # Required. Component capability configuration, description of the capabilities of custom components exposed to lesscode
     |-- index.vue # Required. Component implementation source code
     |-- components/ # Recommended. Referenced subcomponent directory
     | ...... # Implementation of ajax mock
     |-- doc/ # Documentation project of BlueKing front-end development scaffolding. The details here have nothing to do with the actual project, so I will not introduce them in detail. If you are interested, you can check it yourself (the content in the doc will not affect the actual project)
     |......
     |-- statics/ # Recommended. Static resource directory
     |......
```

### Start creating component project

```bash
1. Create the custom component project home directory component-project
mkdir component-project

2. Enter the project main directory
cd component-project

3. Unzip the component development demo sample package to the above directory

4. Develop component functions (file ./index.vue)
touch index.vue

5. Expose components to LessCode’s capability configuration (file ./config.json)
touch config.json
```

### config.json (capability configuration exposed to LessCode)

<table class="table">
     <tr>
         <th>Field name</th>
         <th>Type type</th>
         <th>describe describe</th>
     </tr>
     <tr>
         <td>type</td>
         <td>String</td>
         <td>The tag name displayed in the source code (only lowercase English letters are supported)</td>
     </tr>
     <tr>
         <td>name</td>
         <td>String</td>
         <td>English name displayed on the page</td>
     </tr>
     <tr>
         <td>displayName</td>
         <td>String</td>
         <td>Chinese name displayed on the page</td>
     </tr>
     <tr>
         <td>events</td>
         <td>Array</td>
         <td>Custom events supported by components</td>
     </tr>
     <tr>
         <td>styles</td>
         <td>
             Array, optional values are as follows:
             <p>display: type of generated box</p>
             <p>size: css box model (width, height)</p>
             <p>padding: css box model padding</p>
             <p>margin: css box model margin</p>
             <p>font: font</p>
             <p>border: border</p>
         </td>
         <td>Supported css style settings</td>
     </tr>
     <tr>
         <td>props</td>
         <td>Object</td>
         <td>Property configuration supported by the component</td>
     </tr>
     <tr>
         <td>directives</td>
         <td>Array</td>
         <td>Supported command configuration</td>
     </tr>
</table>

:::info
events - The component internally supports vue's custom events (this.$emit('click')), and the configuration hopes that those events can be exposed to LessCode
:::

```js
// events
{
     ...
     events: [
         {
             name: 'click', // The component supports click events
             tips: 'Response to the click event of the component' // Event function description
         },
         {
             name: 'foucs', // The component supports focus events
             tips: 'Response to the component's focus event' // Event function description
         }
     ]
}
```

:::info
props - the component supports configuring those props (consistent with the use of vue custom components)
:::

```js
// props
{
     ...
     // Component supports configuration value
     value: {
         type: 'string', // type (string, number, array, object, boolean)
         val: 'hello world!!!', // default value
         options: [] // Optional list of values
         tips: 'blank tip', // data usage description
     }
}
```

:::info
directives - supports configuring those directives
:::

```js
// directives
{
     [
         ...
         {
             type: 'v-bind', // Instruction type
             prop: 'disabled', // The property to which the directive is bound
             val: '', // variable name bound by the instruction
             modifiers: ['sync'], // Instruction modifier, this field is optional
             defaultVal: false //The default value of the instruction binding variable
         }
     ]
}
```

### Local debugging

#### Local debugging steps for custom components:

> 1. Initialize a complete vue application (using BlueKing front-end scaffolding [bkui-cli](https://www.npmjs.com/package/bkui-cli))
>
> 2. Run the front-end project initialized in the previous step
>
> 3. Introduce the developed custom components into the application as components referenced in the application (in the BlueKing front-end scaffolding initialization project, usually in the components directory)
>
> 4. Use your custom components in the application and test the logic of the components
>
> Note that the css processing tool in the application needs to be configured as postcss

#### After local development and debugging is completed, to ensure that the components can be used online, the following things need to be done:
> 1. Add the config.json file in the root directory of the component project and follow the above steps to write the configuration items
>
> 2. Remove vue, bk-magic-vue, etc. in package.json, which are already built-in dependencies on the platform, to reduce component package size.
>
> 3. Remove the `import Vue from 'vue'` statement in the application entry file and ensure that custom components use the vue instance provided by the platform to register instructions, components, etc.
>
> 4. Modify the interface calling method. The local debugging interface calling is uniformly modified to call the getApiData method in the platform function management. Pay attention to whether there are differences in the fields of the local debugging interface and the online interface.

### Development completed and packaged

```bash
# Complete the development of custom component functions and enter the directory one level above the root directory of the custom component project, ../component-project
cd ../component-project

# Package in the current directory to get component-project.zip (you need to install the packaging tool first npm i -g @blueking/lesscode-cli)
bklc build component-project
```

### Upload

#### Log in to the BlueKing LessCode

> Log in to return to the homepage

#### Select an application and enter application management

> Select the application to be edited in the application list, or create a new application (the application will automatically enter the application management page if it is successfully created)

<img src="./images/project-list.png" alt="grid" width="600" class="help-img" />

#### Create a new custom component

> Select custom component management in the optional tab on the left to enter the custom component management page
>
> Click the New button to upload the custom component. If a custom component has been uploaded, the uploaded custom component will be displayed. Custom component management can be performed on the current page.
>
> The components in use tab will display customized usage records

<img src="./images/component-upload.png" alt="grid" width="600" class="help-img" />

#### Upload custom components (component-project.zip)

> Click the New button and a pop-up box for creating a new custom component will appear.
>
> Select the custom component package (component-project.zip) to be uploaded in the first item of the operation form
>
> After the upload is successful, the config.json in the custom component package will be automatically parsed, the provided type, name, and displayName will be returned and automatically backfilled into the corresponding form items.

<img src="./images/component-create.png" alt="grid" width="600" class="help-img" />

### use

#### Specify the page using the component
> Select the page to be edited in the page list, or create a new page to edit

<img src="./images/page-list.png" alt="grid" width="600" class="help-img" />

#### Drag and drop components
> The uploaded components will be automatically registered on the page editing page
>
> Enter the page editing page and select the custom component tab
>
> Find the component you want to use and drag it to the editing area

<img src="./images/component-use.png" alt="grid" width="600" class="help-img" />

#### Edit component function
> Select the component to be operated in the editing area
>
> Select the operation tab to be performed in the configuration panel on the right to complete the page function configuration

<img src="./images/component-operation.png" alt="grid" width="600" class="help-img" />
