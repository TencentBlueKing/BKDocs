# Full Text Search

## Search rules

* Keyword search

   Retrieve records containing a keyword
> Example: For example, the search keyword is "error"
> Result: Return records containing "error" within a certain time range. The time range can be selected.


* Fuzzy search

   Retrieve records matching fuzzy matches. ‘?’ replaces one character, ‘*’ replaces 0 or more characters
> Example: For example, fuzzy search keyword "logi?err*"
> Result: Return records with one character between logi and err, and 0 or more characters after err.


* Field search

   The search style is, for example, "field name: search keywords" to search for records containing keywords in the field content (the field type must be a string type)
> Example: For example, the search statement is "log:error"
> Result: Return the records whose field name is log and the log contains error


* Combined search

   The search style is, for example, "Search keyword 1 Search keyword 2". The two keywords are searched as a whole without segmentation.
> Example: For example, the search statement is "login error"
> Result: Return records containing "login error"


* AND search

   The search style is, for example, "Search keyword 1 AND Search keyword 2", which returns records that match keyword 1 and keyword 2.
> Example: For example, the search statement is ip:"10.0.0.1" AND log:"error"
> Result: Return the record whose IP is 10.0.0.1 and the log contains error


* OR search

   The search style is, for example, "Search keyword 1 OR Search keyword 2", which returns records that match keyword 1 or keyword 2.
> Example: For example, the search statement is ip:"10.0.0.1" OR log:"error"
> Result: Return the record whose IP is 10.0.0.1 or the log contains error


* NOT search

   The search style is, for example, "Search keyword 1 NOT Search keyword 2", which returns records that match keyword 1 but do not match keyword 2.
> Example: For example, the search statement is ip:"10.0.0.1" NOT log:"error"
> Result: The returned IP is 10.0.0.1, but the log does not contain error records



  *Precautions*:

  * If the search content contains characters such as \ + - && || ! () {} [] ^" ~ * ? : \, you need to add backslash\ escape, such as \\" keyword.

  * The above query syntax is a common query. If you use other queries, please refer to:
     https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html#query-string-syntax