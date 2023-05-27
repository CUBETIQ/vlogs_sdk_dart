// ignore_for_file: non_constant_identifier_names

import 'package:test/test.dart';
import 'package:vlogs/vlogs.dart';

void main() {
  final APP_ID = "72bd14c306a91fa8a590330e3898ddcc";
  final API_KEY = "vlogs_gX9WwSdKatMNdpUClLU0IfCx575tvdoeQ";

  group('Run collecting the logs', () {
    final sdk = VLogs.create(APP_ID, API_KEY);

    setUp(() {
      expect(sdk, isNotNull);
    });

    test('Emit the logs to collector', () async {
      var request = Collector.builder()
          .message("Hello World")
          .source(CollectorSource.mobile.name)
          .type(CollectorType.log.name)
          .build();

      var response = await sdk.collect(request);
      expect(response.id, request.getId());
    });
  });
}
