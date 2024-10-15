# Service performance

BlueKing API Gateway adopts a high-performance framework and supports high concurrency. You can safely access your resources.

The test machine has 8 cores and 16 G. The single-machine concurrency performance is as follows:

indicator | value
--- | ---
Support maximum number of concurrencies | 10000+
Supports the number of requests processed per second | 30000+

Note: Horizontal expansion is supported, and machines can be added to enhance service performance.

## Access performance loss

Because the BlueKing API gateway supports user authentication, frequency verification and other functions, when the interface provides external services through the API gateway, the time consumption will increase by about 10ms.

If you use it in actual use, you will find that the performance loss after access exceeds 20ms. Please contact us to help you solve it.