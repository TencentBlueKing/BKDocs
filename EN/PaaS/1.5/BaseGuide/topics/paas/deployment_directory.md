## When to Use the Build Directory

If you place both frontend and backend code in a single code repository, the directory structure is as follows:

```

├── docs
├── src
│   └── backend
│       └── bin
│           └── post-compile
│           └── pre-compile
│       └── requirements.txt
│   └── frontend
│       └── package.json
└── README.md
```

- `src/backend` is used to store the code for the backend module (backend)
- `src/frontend` is used to store the code for the frontend module (default)

In this case, you only need to specify the `Build Directory` when creating the "Application\Module". You can also modify it after creation on the following pages of the application:

- Cloud Native Application: 'Module Configuration' - 'Build Configuration'
- Regular Application: 'Module Management' - 'Source Code Repository Management'

## Setting the Deployment Directory

As in the above code example, set the deployment directory for the frontend module (default) to `src/frontend`, and the deployment directory for the backend module (backend) to `src/backend`.

Note:

- If the build directory is not specified, it defaults to the root directory.
- The build directory must contain all the necessary code, such as [build phase hooks](./build_hooks.md) (pre-compile and post-compile), which can only operate on files under the build directory.