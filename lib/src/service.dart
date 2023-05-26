import 'package:vlogs/src/model.dart';
import 'package:http/http.dart' as http;

class VLogsService {
  late final String url;

  VLogsService(String baseUrl) {
    url = '$baseUrl/api/v1/collector';
  }

  Future<CollectorResponse> post(String body, {headers}) async {
    var request = http.Request('POST', Uri.parse(url));
    request.body = body;
    // print("Request Body: ${request.body}");

    if (headers != null) {
      request.headers.addAll(headers);
    }

    var response = await request.send();

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      var json = await response.stream.bytesToString();
      return CollectorResponse.fromJson(json);
    } else {
      throw Exception(
          'Failed to post data to vlogs server with status code: ${response.statusCode}');
    }
  }
}
