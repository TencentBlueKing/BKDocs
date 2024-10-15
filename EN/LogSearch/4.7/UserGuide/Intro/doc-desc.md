# Documentation description

It mainly describes the document format requirements. In addition to the general BlueKing document specifications, there are also monitoring recommended document description methods.

## Monitoring platform documentation

### Document directory

* Product introduction: Briefly introduce the monitoring platform product and introduce its advantages.
* Design concept: If you want to use the monitoring platform better, both users and developers are recommended to understand the design concept first, which will include the monitoring architecture, data model and terminology explanations.
* Quick start: Use the monitoring platform directly without checking the monitoring function. You will have an intuitive feeling through the quick start.
* Product functions: All function descriptions and monitoring function introductions are based on the navigation structure of the monitoring platform. If you encounter problems during daily use, you can search them like a dictionary.
* Scenario cases: Common use cases in daily use. Some scenarios have more than one solution. If your needs are very clear, this document will be a very good guide.
* Secondary development: If you want to have secondary development needs based on the monitoring platform.
* FAQ: Frequently asked questions and quick answers area.

### Basic format of product function introduction

The function introduction basically includes the following parts:

1. Basic introduction: Basic introduction to the function page and its complete functions.
2. Preliminary steps: Before you begin, you need to prepare the environment and understand some basic concepts before officially starting.
3. Function list: What Can I Do
     * List of main functions: A simple list of main functions
     * Function description: Also known as common functions, they are also the main functions used. The basic functions will be introduced first, and then the advanced functions will be introduced.

### Commonly used small styles

* Navigation path: use `→`
     * Such as `Import function location: Navigation → Monitoring Configuration → Plug-in → Import`
* Main configuration process: use `(x)` as

     ```bash
     **Main configuration process**:

     * (1) Select the dashboard name
     * (2) New view
     * (3) Select indicators
     * (4) Select graphics
     * (5) Save and adjust view position
     ```
* Use `[x]` for screenshot labeling

*Remarks: Tips or information that may be useful emerge.

     * Chinese

     >> Description:

     *English

     >> Note:

* Attention: Draw attention to important information to avoid pitfalls.

     * Chinese

     >> ! Note:

     *English

     >> ! Caution:

* Warning: Indicates danger or important information that needs to be followed.

     * Chinese:

     >>!! Warning:

     *English

     >>!! Warning:

* code block

     ```json
     {

     }
     ```

## General specifications

### Copywriting style

1. Be sure to check more to make sure there are no typos. Do not use even homophonic typos in popular slang, such as "wall crack", "children's shoes", "programmer", etc.
2. Use a blank line to separate paragraphs. **Don't** leave whitespace characters at the beginning of a paragraph.
3. Please delete words, phrases, and sentences that have no obvious effect on expressing the meaning, and reduce the length of the copy to the minimum without affecting the expression effect.
4. Avoid spoken language and use standardized written language. Example: Avoid using spoken words such as "mo", "oh" and "hang up".
5. Try to avoid mixing Chinese and English.
6. Please pay attention to the usage of “的”, “地” and “得”.
7. First person: It is recommended to use "BlueKing" and "we", but it is not recommended to use "editor" and "author".
8. Avoid long, complex sentences with multiple prepositions. Pay attention to the complete sentence components.
9. Product name consistency. The product name must be consistent with the homepage navigation of the official website and cannot be written randomly.
10. The order of content and the sorting in various lists need to comply with conventions and cannot be arranged arbitrarily. They should be consistent with the navigation order of the official website homepage.
11. Reasonable naming and concept naming should be easy to understand and preferably without ambiguity.

### Use of spaces when Chinese, English, and numbers are mixed.

1. Spaces need to be added between Chinese and English, such as package management SaaS, which adopts a version management concept similar to Git.
2. Spaces need to be added between Chinese characters and numbers. For example: Enterprise Standard Edition has 7*24 hours of exclusive service.
3. There needs to be a space between the number and the unit. For example: 0-100 services require a system configuration of at least 4 cores and 8 G, and a /data disk of at least 50 G.
4. There are no spaces between Chinese symbols and other characters, such as: BlueKing log retrieval product is a SaaS launched to solve the problem of difficulty in querying logs in operation and maintenance scenarios. It is based on the industry's mainstream...
5. Spaces need to be added between links. For example: BlueKing document writing syntax is Markdown. For more information, please refer to [Google](.).

### Punctuation related

1. In Chinese only or mixed Chinese and English, Chinese/full-width punctuation will be used.
2. If a whole English sentence appears in a mixed Chinese and English sentence, English/half-width punctuation will be used in the English sentence.
3. Ellipsis: Please use "..." standard usage, do not use "...".
4. Exclamation mark: Do not use "!!". Try to avoid using "!". Please calm down first before sitting in front of the computer and typing on the keyboard.
5. Tilde: Please do not use "~" in the article. There are many other ways to express cuteness lively.

### Correct usage of nouns

1. Capitalize proper nouns, such as: GitHub, not github, Github or GITHUB.
2. Use correct abbreviations, such as: JavaScript, HTML5, not Js, h5.