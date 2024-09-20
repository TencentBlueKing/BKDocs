## Guidelines for using interactive components

### What is an interactive component?

Different from conventional `button`, `text` and other components, interactive components allow users to control the component to open or close in a certain state through variables. The component has a strong binding relationship with specific conditions. For example, the `dialog component' is generally not a component that will stay and be displayed for a long time. Instead, it will be displayed only after being triggered under certain circumstances (such as form submission, announcement display). This type of component is called **interaction. Type components**

The interactive components available on the current platform include `dialog` and `sidebar`.

### Use of interactive components

Like regular components, drag it into the canvas from the component library on the left and configure its properties through the right panel; the content area of the interactive component is the `Layout` slot, and you can drag other components in its content area to customize the interaction. The content of the component.

<img src="./images/interactive-1.png" alt="grid" height="500" class="help-img">

:::info
When activated, the interactive component will occupy the screen and canvas, so only one interactive component can be edited in the canvas editing area at the same time.

If you need to switch components, switch the left panel to the component tree and click on the component in the component tree to activate the component you want to edit.

The eye chart on the right side of the interactive component can be clicked to close or open the display state of the current interactive component.
:::

<img src="./images/interactive-7.png" alt="grid" height="500" class="help-img">

### Notes on interactive components

#### Status binding
::: warning
In any case, interactive components should be bound to a variable to determine whether to display or not. Static values will prevent normal interaction.

Here we will give a detailed explanation of the state binding of the two components `Dialog` and `Sidebar`.
:::

---

The dialog component binds its state through `v-model` (that is, `value`) to control whether it is displayed or not. By default, it is a value type, which is a static type. In this state, the interactive component will not work properly in the real environment, so it needs to bind variables or expressions to it.

<img src="./images/interactive-2.png" alt="grid" height="500" class="help-img">

Select the variable in the upper right corner of the value attribute and create a new variable in the drop-down menu

<img src="./images/interactive-3.png" alt="grid" height="300" class="help-img">

Add a new variable, pay attention to select `Boolean` as the initial type, and set its default value according to the actual situation (generally the default value is `false`, which needs to be triggered by certain conditions)

<img src="./images/interactive-4.png" alt="grid" width="500" class="help-img">

After creation, in the drop-down list of variables, select the variable you just created.

<img src="./images/interactive-5.png" alt="grid" height="300" class="help-img">

Finally, just change the variable to `true` when you need it to appear.

In order to simulate here, create a `switcher` component and bind the same variables, so that when the `switcher` is opened, the pop-up box will appear, otherwise it will disappear.

<img src="./images/interactive-6.png" alt="grid" height="500" class="help-img">


---

The state binding attribute of the `Sidebar` component is `is-show`, and its configuration method is consistent with the `Dialog`. Please refer to the above configuration steps.

<img src="./images/interactive-8.png" alt="grid" height="500" class="help-img">