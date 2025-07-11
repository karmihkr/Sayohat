import 'package:http/http.dart' as http;
import 'package:sayohat/api_clients/request_types.dart';
import 'package:sayohat/project_settings.dart';

class YandexApiClient {
  var client = http.Client();

  Future<http.Response> request(
    RequestType type,
    String endpoint,
    Map<String, dynamic> params,
    Map<String, String> headers,
    Map<String, String> body,
  ) {
    if (type == RequestType.get) {
      return client.get(
        Uri.http(projectSettings.apiUrl, endpoint, params),
        headers: headers,
      );
    }
    return (type == RequestType.post
        ? client.post
        : type == RequestType.delete
        ? client.delete
        : client.put)(
      Uri.http(projectSettings.apiUrl, endpoint, params),
      headers: headers,
      body: body,
    );
  }
}

var yandexApiClient = YandexApiClient();
