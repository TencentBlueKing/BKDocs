## Introduction to Persistent Storage Functionality

In the lifecycle of application development, persistent data storage is a fundamental and critical requirement. To address this need, the BlueKing PaaS platform provides developers with persistent storage functionality.

The persistent storage feature in the Developer Center offers a shared data source for multiple modules and processes, enabling data sharing and interaction, while ensuring data persistence and integrity in the event of system failures or restarts.

Developers can manage and maintain persistent storage through various operations on the `Persistent Storage` management page.

## Application Scenarios

**Shared Data Access**: When multiple modules or processes need to access the same data, persistent storage provides a centralized storage solution.

**Configuration Management**: Store application configurations or other sensitive data and share them with all modules or processes.

**Data Persistent Storage**: Provides an application-independent storage solution to ensure the persistence of data.

**Data Backup**: Serves as a backup storage for data, enhancing data security and reliability.

## Usage Methods

**Enable Persistent Storage Feature**: Users contact the platform administrator to enable the persistent storage feature for the application.

**Create Persistent Storage**: Go to `Developer Center -> Application Configuration -> Application Configuration -> Persistent Storage` and select to create a new persistent storage according to your needs.

**Mount Persistent Storage**: Go to `Developer Center -> Module Configuration -> Mount Volume -> Add Mount` and select the persistent type of mount resource type to create a mount.