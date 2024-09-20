## How to develop a form query page
### Step 1: Drag and drop the "query selection", "table" and "pagination" components to the canvas

<img src="./images/case-table1.png" alt="grid" width="640" class="help-img">

### Step 2: Configure component instructions

- Configure the "table" component attribute instruction "v-bind:data" for setting table data

- Configure the "query selection" component attribute instruction "v-model" to obtain query input keywords

- Configure the "paging" component attribute instruction "v-bind:count" to set the total amount of paging data

- Configure the "paging" component attribute instruction "v-bind:current.sync" to obtain the current page


**Notice:**

When editing a function

1. You can use the lesscode.command value, and you must select the corresponding attribute command value through the editor's automatic completion function to obtain or modify the component attribute value configured with the command in the current page.

2. You can use lesscode. function name, and you must use the editor's auto-complete function to select the function you need to call.

<img src="./images/case-table3.png" alt="grid" width="640" class="help-img">


### Step 3: "Table" component properties and event configuration

- Configure the table data source initial loading function getTableData

<img src="./images/case-table2.png" alt="grid" width="640" class="help-img">

- Return field configuration header based on data source

<img src="./images/case-table4.png" alt="grid" width="640" class="help-img">

### Step 4: "Query Selection" component event configuration

- Table data update function updateTableData

<img src="./images/case-table10.png" alt="grid" width="640" class="help-img">

- Configure the "enter" event function to trigger the query

<img src="./images/case-table5.png" alt="grid" width="640" class="help-img">

Event function selectData

<img src="./images/case-table6.png" alt="grid" width="640" class="help-img">


### Step 5: "Paging" component event configuration

- Configure the "click" event function to trigger paging query operations

<img src="./images/case-table7.png" alt="grid" width="640" class="help-img">

Event function selectData2

<img src="./images/case-table8.png" alt="grid" width="640" class="help-img">

### Step 6: Preview the effect

<img src="./images/case-table9.png" alt="grid" width="640" class="help-img">