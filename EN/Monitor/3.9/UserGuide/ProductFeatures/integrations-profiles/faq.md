## Where does the query item on the left of Profile come from?

The query item on the left obtains Tags and Labels in the Profile data. If you want to add a custom k-v, you can add `Tags` in the `pyroscope` configuration.

## Why does uploading Profiling file get no results?
On the premise of ensuring that the data format is correct, you can see whether the status of the parsing failed, click upload details to see the specific reason.

## Profiling is already being reported but the page still has no data?

- Check whether there are errors in project profiling, and whether the Token and reported address are correct. If the report fails, pyroscope prints a request log.
- If no errors are reported, ensure that the reporting has been going on for at least 10 minutes (the background detects the Profile service every 10 minutes).
- If there is still no data, contact the administrator for troubleshooting