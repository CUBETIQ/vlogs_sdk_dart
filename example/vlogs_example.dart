// ignore_for_file: non_constant_identifier_names

import 'package:vlogs/vlogs.dart';

void main() async {
  final APP_ID = "72bd14c306a91fa8a590330e3898ddcc";
  final API_KEY = "vlogs_gX9WwSdKatMNdpUClLU0IfCx575tvdoeQ";

  final sdk = VLogs.create(APP_ID, API_KEY);

  var request = Collector.builder()
      .message("Hello World")
      .source(CollectorSource.mobile.name)
      .type(CollectorType.log.name)
      .build();

  // Run this to test non-blocking collect
  sdk.collectAsync(request);

  // Run this to test blocking collect
  var response = await sdk.collect(request);

  // Output the response
  print("Response: ${response.toJson()}");
}
