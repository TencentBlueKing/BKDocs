> Based on the log provided by Elasticsearch, please refer to [elasticsearch query string syntax description](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html#query-string-syntax) for more query syntax descriptions

## Example

- Query requests with a status code of 500: `status: 500`
- Query all requests with a status code other than 200: `NOT status:200`
- Query all requests with a status code of 20X: `status: 200 OR status: 201 OR status:204`
- Query request path /api/httpbin/prod/get and status code 200: `http_path: "/api/httpbin/prod/get" AND status: 200`
- Query request path starting with /api/httpbin: `http_path: "/api/httpbin/*"`
- Query based on request_id: `request_id: 257d672d-295a-4b5f-9478-561378a24434`
- Backend request duration is greater than 1s (1s=1000ms): `backend_duration: [1000 TO *]`
- Total request duration is greater than 1s (1s=1000ms): `request_duration: [1000 TO *]`

## Field description that can be used as a query

| Field name | Meaning |
| ------ | ------ |
| request_id | Request ID, specific description [X-Bkapi-Request-ID (request_id)](./request-id.md) |
| app_code | BlueKing application, only resources with [application authentication](./authorization.md) enabled will have values ​​|
| client_ip | Client IP |
| stage | Environment |
| resource_id | Resource ID |
| resource_name | Resource name |
| method | Request method |
| http_host | Request domain name |
| http_path | Request path |
| params | QueryString |
| body | Body |
| backend_method | Backend request method |
| backend_scheme | Backend Scheme |
| backend_host | Backend domain name |
| backend_path | Backend path |
| response_body | Response body |
| status | Status code |
| request_duration | Total request duration |
| backend_duration | Request backend duration |
| code_name | Error code name |