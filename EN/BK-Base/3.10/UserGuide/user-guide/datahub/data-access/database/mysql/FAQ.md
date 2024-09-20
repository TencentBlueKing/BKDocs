# DB Access FAQ

### How to access UUID primary key type database table

* ID access in database collection must be of integer type, otherwise the access will fail. If the primary key is another string type such as UUID type, you can use the time field to access it.
* If neither access is consistent, the user needs to use [custom access] (../custom/concepts.md) and use their own script to report data through GSE.

### When MySQL type database is connected, why are the integer type fields parsed into Bool type?

Due to the storage characteristics in MySQL, bool type fields are stored using tinyint at the bottom. Therefore, integer data of tinyint type will also be parsed into bool type. In the subsequent cleaning process, you need to pay attention to the cleaning rules of this field.