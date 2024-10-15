# Gateway API request log query rules

## Advanced Search

In addition to fuzzy searches using keywords, log retrieval also supports more complex advanced queries.
You can use syntax like `client_ip:xx.xx.xx.xx` to query specific fields, and combine keywords such as `AND` and `OR` to complete more complex queries. for example:

- Query the request whose result code is not 200: **NOT status:200**
- Query all POST requests for a specific IP: **client_ip:xx.xx.xx.xx AND method:POST**

For more query syntax instructions, please refer to [elasticsearch query string syntax instructions](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html#query-string -syntax).

### Log query all field names

<style style="text/css">
table {width: 50%}
</style>

Field meaning | Field name
--- | ---
request_id | request_id
environment | stage
Resource ID | resource_id
BlueKing App | app_code
Client IP | client_ip
request method | method
Request domain name | http_host
Request path | http_path
Backend request method | backend_method
Backend Scheme | backend_scheme
Backend domain name | backend_host
backend path | backend_path
status code | status
Time spent requesting the backend | backend_duration