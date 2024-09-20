### Request method

POST


### request address

/api/c/compapi/v2/itsm/get_tickets/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Get documents

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| sns | array | no | filter according to the single number list |
| creator | string | No | Filter by document creator |
| create_at__lte | string | No | The creation time is greater than or equal to, format: "YYYY-MM-DD hh:mm:ss" |
| create_at__gte | string | No | The creation time is less than or equal to, format: "YYYY-MM-DD hh:mm:ss" |
| page | int | No | request page number, default is 1 |
| page_size | int | No | The amount of data per page, the default is 10, the maximum is 10000 |
| username | string | No | Filter the user's to-do, the amount of data per page, the default is 10, the maximum is 10000 |

### Request parameter example

```json
{
     "bk_app_secret": "xxxx",
     "bk_app_code": "xxxx",
     "bk_token": "xxxx",
     "sns": ["NO2019091610001755"],
     "creator": "admin",
     "create_at__lte": "2019-09-16 10:00:00",
     "create_at__gte": "2020-09-16 10:00:00",
     "page": 1,
     "page_size": "10",
     "username": "admin"
}
```
### return result example

```json
{
     "message": "success",
     "code": 0,
     "data": {
         "page": 1,
         "total_page": 1,
         "count": 1,
         "next": null,
         "previous": null,
         "items": [
             {
                 "id": 1,
                 "sn": "NO2019091610001755",
                 "title": "a",
                 "catalog_id": 3,
                 "service_id": 1,
                 "service_type": "request",
                 "flow_id": 1,
                 "current_status": "RUNNING",
                 "comment_id": "",
                 "is_commented": false,
                 "updated_by": "admin",
                 "update_at": "2019-09-16 10:01:07",
                 "end_at": null,
                 "creator": "admin",
                 "create_at": "2019-09-16 10:00:17",
                 "bk_biz_id": -1,
                 "ticket_url": "xxxx"
             }
         ]
     },
     "result": true
}
```

### Return result parameter description

| Field | Type | Description |
|-----------|-----------|-----------|
|result| bool | return result, true means success, false means failure |
|code|int|return code, 0 means success, other values mean failure|
|message|string|Error message
|data| object| return data |

### data

| Field | Type | Description |
|-----------|-----------|-----------|
|count| int | return count |
|next|string|next link|
|previous|string|Previous page link|
|items| array| List of document data |
|page| int| page number |
|total_page| int| total page number |

### items

| Field | Type | Description |
|-----------|-----------|-----------|
| id | int | document id |
| catalog_id | int | service catalog id |
| service_id | int | service id |
| flow_id | int | process version id |
| sn | string | odd number |
| title | string | document title |
| current_status | string | current status of the document |
| current_steps | array | current step of document |
| comment_id | string | document comment id |
| is_commented | bool | Whether the document has been commented |
| updated_by | string | last updated by |
| update_at | string | Last update time |
| end_at | string | end time |
| creator | string | B/L |
| create_at | string | creation time |
| is_biz_need | bool | Whether related to business |
| bk_biz_id | int | business id |