# Tredis

Supports static association types, key-value types and list types.

Legend, Tredis node

![](../../../../assets/dataflow/components/storage/dataflow-tredis.png)

Common node configuration

- Node name: automatically generated, consisting of the upstream result table and the current node type
- Result data table: inherited from the upstream node
- Storage cluster: optional cluster provided by the project party
- Expiration time: Tredis data storage time

#### Static association type

Tredis is stored in a specified format and can be used as a real-time related data source.

Configuration example:

![](../../../../assets/dataflow/components/storage/dataflow-tredis-join.png)


#### key-value type

It is up to the user to determine how keys and values are assembled.

- Node configuration
- Whether to overwrite: whether to overwrite the value of the existing key, overwritten by default
- Delimiter: the delimiter used for field combinations in key or value
- key prefix: You can add a prefix to the key as a whole, the default is empty

- Field configuration
- key: Which fields of the result table are used to combine key
- value: Which fields of the result table are used to combine value

Configuration example:

![](../../../../assets/dataflow/components/storage/dataflow-tredis-kv.png)

#### list type

Each piece of data is stored in Tredis in JSON format, and the data storage time can be configured.

Configuration example:

![](../../../../assets/dataflow/components/storage/dataflow-tredis-list.png)