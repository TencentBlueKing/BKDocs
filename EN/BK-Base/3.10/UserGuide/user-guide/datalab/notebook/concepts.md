# Notebook Service

## What is Notebook?

Notebook is an interactive document. The document is opened in the form of a web page. It supports writing and running code in the web page document. The execution results of the code will be saved together with the related code, which facilitates the display of code results and rapid iteration.

Currently, the programming language environment provided by Notebook is Python. It also provides custom magic commands in Notebook such as: %%bksql, which supports writing SQL in Notebook for data query. For details, please refer to [BKSQL query syntax] (./bksql.md) .

## Features

Features currently provided by Notebook tasks:

- Interactive programming, read while writing, read while writing
- Instant results output and save, execute once and read multiple times
- Support code and result reuse between code blocks
- Supports multi-language kernel and can write Python, SQL and other codes

## Core Features

Notebook tasks provide interactive documents. Its core is "what you see is what you get" and supports writing and running codes in web documents. The execution results of the code will be saved together with related codes, which facilitates the display of code results and rapid iteration. We can understand Notebook as a piece of scratch paper, on which we can think and explore. Each step of exploration will have immediate results output, which allows us to adjust decisions based on the results and proceed to the next step of exploration.