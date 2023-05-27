// ignore_for_file: non_constant_identifier_names

import 'package:logger/logger.dart';
import 'package:vlogs/src/model.dart';
import 'package:vlogs/src/service.dart';
import 'package:vlogs/src/util.dart';

class VLogs {
  static final _logger = Logger();
  static final String NAME = 'vlogs';
  static final String VERSION = '1.0.0';
  static final String VERSION_CODE = '1';
  static final String DEFAULT_VLOGS_URL = "https://vlogs-sg1.onrender.com";
  static final String APP_ID_HEADER_PREFIX = "x-app-id";
  static final String API_KEY_HEADER_PREFIX = "x-api-key";
  static final int DEFAULT_CONNECT_TIMEOUT = 60; // seconds

  late VLogsOptions _options;
  late VLogsService _service;

  VLogs(VLogsOptions options) {
    if (options.appId == null || options.apiKey == null) {
      throw Exception("AppId and ApiKey are required");
    }

    if (options.apiKey!.isEmpty || options.appId!.isEmpty) {
      throw Exception("AppId and ApiKey are required");
    }

    // Set default options
    _options = options;
    _options.url ??= DEFAULT_VLOGS_URL;

    // Initialize service
    _service = VLogsService(_options.url!);

    _logger.i(
        "VLogs: Initialized AppID: ${_options.appId} | SDK Version: $VERSION-$VERSION_CODE");
  }

  Future<CollectorResponse> collect(Collector request) async {
    _logger.d("VLogs: Collecting logs for ${request.getId()}");

    var headers = {
      APP_ID_HEADER_PREFIX: _options.appId!,
      API_KEY_HEADER_PREFIX: _options.apiKey!,
      "Content-Type": "application/json",
    };

    var hostname = Util.getSystemHostname();
    var sender = Util.getSystemUsername();
    var sdkInfo = SDKInfo.builder()
        .hostname(hostname)
        .sender(sender)
        .name(VLogs.NAME)
        .version(VLogs.VERSION)
        .versionCode(VLogs.VERSION_CODE)
        .build();

    if (request.target == null) {
      if (_options.target != null) {
        request.target = _options.target;
      } else {
        request.target = Target.builder().build();
      }
    } else {
      if (_options.target != null) {
        request.target!.merge(_options.target!);
      }
    }

    // Set SDK info to request
    request.target!.sdkInfo = sdkInfo;

    // Append user agent to request
    request.userAgent ??= "vlogs-dart-sdk/$VERSION-$VERSION_CODE ($hostname)";

    var response = await _service.post(request.toJson(), headers: headers);
    return response;
  }

  void collectAsync(Collector request) {
    collect(request)
        .then((value) => {_logger.d("VLogs: Collected logs response: $value")})
        .catchError((error) {
      _logger.e("VLogs: Error while collecting logs: $error");
      return error;
    });
  }

  static VLogs create(VLogsOptions options) {
    return VLogs(options);
  }

  static VLogs createWith(String appId, String apiKey) {
    return create(VLogsOptions(
      appId: appId,
      apiKey: apiKey,
    ));
  }
}
