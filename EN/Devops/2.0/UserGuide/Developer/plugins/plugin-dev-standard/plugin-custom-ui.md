 # Plugin customize UI 

 ## customize Plugin Front-end Framework 

 > As more and more user use the store Develop Pipeline Plugin, users have higher requirements for Components and interaction Scene.  
 > Since most of the Components and interactive Scene proposed by individual user are not general, the platform cannot be packaged one by one, so a set of customize development Plugin front-end framework is designed and Develop.  
 > The framework opens the front-end part of the Plugin to customize Develop, which is suitable for implementing the front-end part of the plug-in for complex interaction Scene. 

 ## summary 

 * Divide Pipeline Edit Plugin panel into an gateway load it in the form of iframe. The content of iframe is customize by the user. 
 * When you click the Plugin, the upper layer of the platform will pass the atomValue and atomModel of the plug-in to the iframe approve postMessage. After the iframe gets the atomModel and atomValue, you can customize the plug-in part. 
 * After the user Input the corresponding Parameter, Update the value to atomValue. When the Plugin panel is close, the value of atomValue will be auto returned to the upper layer of the platform for saving. 

 For vue Develop, we've encapsulated One vue-based scaffolding that integrates BlueKing's magixbox Component, BK-CI Business Name components, BK-CI Plugin capabilities, and an api that communicates with the upper layers of the platform, allowing developers to focus only on the business logic part of the process. 

 ## Framework Directory Structure 

 The bk-frontend directory under the root directory of the Plugin Code Repository is the front-end code root directory. 
 The following Code structure is as follows: 

 ![png](../../../assets/store_plugin_customui_folder.png) 

 ## Develop step 

 * 1. Select "Yes" in the front part of the customize Plugin when new parts in the store 
 * 2. Run: 
  * create bk-frontend directory under the Code root directory 
  * Go to the bk-frontend directory 
  * Copy the framework Code [bkci-customAtom-frontend](https://github.com/ci-plugins/bkci-customAtom-frontend) to the current directory 
  * execute npm install 
  * execute npm run dev Now open the browser and open [http://localhost:8001](http://localhost:8001/), you can see the effect of our built-in simple demo project 
 * 3. Develop: 
  * setting task.json in the bk-frontend/data directory 
  * Develop Plugin Business Name logic in Atom.vue (see the following introduction to plug-in business Logic development for specific development Precautions) 
 * 4. After local Debug is OK: 
  * Copy the content of task.json in the bk-frontend/data directory to task.json in the root directory 

 ## Atom.vue \(Precautions for Develop user Plugin logic\) 

 * When user Develop Plugin in Atom.vue, they need to reference atomMixin, which has built-in communication capabilities and interactive APIs for the upper layer of the platform 

 ```text 
 import { atomMixin }from 'bkci-atom-components' 
 mixins: [atomMixin], 
 ``` 

 * After referencing atomMixin.js, the data has built-in atomValue and atomModel var (Description below): 

  * atomModel: The input part of task.json. In the customize Plugin framework, the input part of task.json can be understood as the data var in the vue file. When you put some setting into task.json, you can get it directly in the atomModel var, which makes the vue file more concise and easy to maintain. 
  * atomValue: The value that needs to be submit to the upper layer of the platform and save to the backend Plugin for execute. The format is as follows: 

  ```text 
  { 
      "item1": "111", 
      "item2": "222" 
  } 
  ``` 

  After the user Revise the corresponding Parameter, Update the value to atomValue. When the Plugin panel is close, the value of atomValue will be auto returned to the upper layer save 

 ## Local Debug 

 > The framework provided a local Debug module, so user can debug the front-end part locally and then submit it 

 package.json provided two packaging commands 

 * npm run dev : Run Debug this project locally. When you run this command, the execute path of the program is roughly main.&gt; js-data/LocalAtom. vue-Atom&gt;.vue 
 * npm run public： execute this command when you are Ready To Release package after local Develop, main.js -&gt;data/PublicAtom.vue -&gt;Atom.vue 
 * In local Develop, the user puts the content of task.json under data/task.json, and after Run npm run dev, the framework will read the input in data/task.json as atomModel, and extract the default value of each Field as the corresponding defaultValue in atomValue. 
 * Application Runtime online, the values of atomModel and atomValue are passed to the iframe by the upper layer of the platform 

 The Debug normal when the user runs it locally, and the effect is the same when the user clicks on the platform Plugin panel after online 

 ## Release 

 After the Plugin is Debug, it is Release approve the store workbench. The preparation process of the release package is as follows: 

 1. execute npm run public packaging 
 2. create a directory named frontend under the Release root Plugin release specification (release. md) 
 3. Copy the package result file\(all files in the dist directory\) to the frontend directory 
 4. Zip all file in the root directory of the Release package and upload them to store approve the workbench 

 ## FAQ 

 1. How to use the built-in BK-CI Component and magixbox component library? 

 * BK-CI Component: The components that can be configured with task.json can also be used directly in the form of components. The properties of components are the setting properties of task.json ([click view](plugin-config.md)). The value change event of BK-CI component library is uniformly encapsulated as:handle-change="functionxxx", where functionxxx has two Parameters, one is the name of the component, and the other is the new value of the component. 
 * There are many kinds of Component in BlueKing Magixbox, which can basically Overwrite the type of components needed for daily Develop. You can directly use the Magixbox component library for development in the framework. For more information, please view [Official The document](https://bk.tencent.com/docs/markdown/开发指南/SaaS开发/开发基础/MagicBox.md). 

 2. When Debug locally, I need to combine a specific project, such as using the selector Components Pull the Code Repository list and certificate list of a certain project. How can I bring the Project information? 

 * You can pass projectId=${projectId} after the URL to be accessed approve query, such as [http://local.XX.com:8001?  projectId=abc](http://local.xx.com:8001/?projectId=abc), BK-CI built-in selector/select-input Components will auto parse the projectId Parameter in the url as the Request parameter 

 3. Is task.json still useful after Develop with customize Plugin framework?  What is the relationship between the two? 

 * To a certain extent, after using the customize framework, even if the input content in task.json is empty, the custom framework can Run normal, but we still recommend that user setting the input part of task.json. The content in the input part will be passed to the iframe through approve atomModel var, which can make the Code more concise. Define the Field required by the Plugin in advance, and facilitate the backend to do some inspection and expansion. On the other hand, users who are used to directly Generate task.json can also refer to the writing in the demo to directly complete the rendering of the field in the form of high-level Components Iteration. The interactive capabilities such as rely configured in task.json can also be directly used after referencing atomMixin. 

 4. There is One task.json in the root directory of the Code repository, and there is also a task.json in the bk-frontend/data directory. What is the relationship between the two, and why not unify them into one? 

 * The specifications of the two task.json are setting in the same way. The task.json under bk-frontend/data is the RawData for local Debug. The value of atomModel in local debugging is the input part. The task.json under the root directory is the data source of the online Application Runtime atomModel. If there is an output part in the Plugin, you can add it in the task.json under the root directory. In the Develop debugging Stage, write and configure task.json in bk-frontend/data first. Before online submit, Copy to the content of task.json in bk-frontend/data to task.json under the root directory (if the output part is added separately). 

 5. How to interact with the upper layer of the platform if Field Check exists during Develop Plugin? 

 * When atomMixin is referenced, the framework has built-in API that encapsulates the status communication with the upper Plugin. When the Parameter Fill In by the user is illegal, call this.setAtomIsError\(true\) to mark The plug-in box in red. At this time, Pipeline cannot be save. When the user enters a valid parameter, call this.setAtomIsError\(false\) to Reset the status back to normal 