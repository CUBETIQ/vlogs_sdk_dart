# vLogs SDK for Dart

A simple way to collect logs and send to the server via simple SDK.

-   [x] Collect the logs
-   [ ] Support local retries

## Usages

```dart
import 'package:vlogs/vlogs.dart';

void main() async {
  final APP_ID = "xxx";
  final API_KEY = "vlogs_xxx";

  final sdk = VLogs.create(APP_ID, API_KEY);

  var request = Collector.builder()
      .message("Hello World")
      .source(CollectorSource.mobile.name)
      .type(CollectorType.log.name)
      .build();

  var response = await sdk.collect(request);
  print("Response: ${response.toJson()}");
}
```

### Contributors

-   Sambo Chea <sombochea@cubetiqs.com>
