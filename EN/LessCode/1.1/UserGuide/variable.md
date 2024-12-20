# Variable Management

In the LessCode platform, users can create APP variables and use them in page development. By using variables, the following requirements can be fulfilled:

- **Dynamically assign values to component properties:** Bind variables to attributes, allowing functions to manipulate variables to get or modify their values, thereby affecting component properties.
- **Dynamically assign values to component directives:** The platform currently provides Vue syntax directives. By binding variables to directives, you can control the behavior of directives via functions.
- **APP global variables:** Define global variables in the APP that can be shared and used across all pages.
- **Assign initial values to variables by environment:** A variable can be configured with initial values for preview, pre-release, and production environments.
- **Use variables in function parameters:** The "Request URL" and "Request Parameters" of remote functions can be assembled and dynamically retrieved using variables.

## Global Variable Management

### Path to Global Variable Management Page:

APP Development (Select APP) -> Variable Management

### Instructions for Using Global Variables:

- You can perform CRUD operations on global variables on the APP variable management page.
- Variables that are already in use can be queried for reference locations and cannot be deleted.
- The variable identifier for global variables is globally unique within the APP.
- Modifying the default value of a global variable will change the default value of the component properties or directives referencing that variable on all pages.

## Page Variable Management

### Path to Page Variable Management Page:

APP Page Canvas -> Page Variables

### Instructions for Using Page Variables:

- APP page variables display details of variables available on the current page (including global variables and page-specific variables).
- You can only operate on page variables; global variables must be managed from the global variable management page.
- Variables already in use cannot be deleted.
- You can perform CRUD operations on page-specific variables.

## Introduction to Initial Variable Types

LessCode currently offers six types of variable initialization for APP development use. These types are only for initialization; variables can be modified within functions.

- **Basic data types (String, Number, Boolean, Array, Object):** These are JavaScript data types, filtered based on data type when bound to properties.
- **Computed variables:** These can be a combination of multiple variables or functions, returning a final value that can be applied to all properties and directives.

## Binding Variables to Functions

Variables can be used in the "Request URL" and "Request Parameters" of remote functions. As shown in the image, you can use `{variable_identifier}` to incorporate variables in the request URL.

<img src="./images/variable-method.png" alt="grid" width="80%" class="help-img" /><br>

## Manipulating Variables in Functions

In functions, you can use the `lesscode` keyword to invoke quick input. You must select the corresponding variable using the editor's autocomplete feature to get or modify variable values. Here's an example:

<img src="./images/variable-in-method2.png" alt="grid" width="80%" class="help-img" /><br>

As shown in the image: Add a new function, and inside the function, you can invoke quick input using the `lesscode` keyword. Based on the prompts, you can find and select the variable you want to modify, and then perform operations on it.
