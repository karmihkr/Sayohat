import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:sayohat/api_clients/request_types.dart';
import 'package:sayohat/api_clients/yandex_api_client.dart';
import 'package:sayohat/project_settings.dart';

class HamsafarApiClient {
  final client = http.Client();

  bool registering = false;

  Future<http.Response> request(
    RequestType type,
    String endpoint,
    Map<String, dynamic> params,
    Map<String, String> headers,
    Map<String, String> body,
  ) {
    if (headers.containsKey("Authorization") &&
        Jwt.isExpired(headers["Authorization"]!.substring(7))) {
      throw http.ClientException("expired");
    }
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

  Future<String> sendTelegramVerificationCode(String number) async {
    http.Response response = await request(
      RequestType.get,
      "/telegram_verification",
      <String, dynamic>{"phone": number},
      {},
      {},
    );
    if (response.statusCode != 200) throw http.ClientException("");
    return jsonDecode(response.body)["request_id"];
  }

  Future<String> obtainAccessToken(
    String phone,
    String telegramRequestId,
    String code,
  ) async {
    http.Response response = await request(
      RequestType.post,
      "/token",
      {"code": code, "request_id": telegramRequestId},
      {
        "accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      },
      {
        "grant_type": "password",
        "username": phone,
        "password": phone,
        "scope": "",
        "client_id": "string",
        "client_secret": "********",
      },
    );
    if (response.statusCode == 417) throw http.ClientException("incorrect");
    if (response.statusCode != 200) throw http.ClientException("");
    return jsonDecode(response.body)["access_token"];
  }

  Future<bool> userExists(String phone) async {
    http.Response response = await request(
      RequestType.get,
      "/user_exists",
      {"phone": phone},
      {},
      {},
    );
    if (response.statusCode != 200) throw http.ClientException("");
    return jsonDecode(response.body)["result"];
  }

  Future<void> registerUser(
    String phone,
    String name,
    String surname,
    String birth,
  ) async {
    http.Response response = await request(
      RequestType.post,
      "/user",
      <String, dynamic>{
        "phone": phone,
        "name": name,
        "surname": surname,
        "birth": birth,
      },
      {},
      {},
    );
    if (response.statusCode != 200) throw http.ClientException("");
  }

  Future<void> registerPlace(String uri) async {
    final token = await persistentSecuredStorage.read(key: 'token');
    final geoInformation = await yandexApiClient.geoInformationByUri(uri);
    http.Response response = await request(
      RequestType.post,
      "/place",
      {...geoInformation, "_id": uri},
      {
        'Authorization': 'Bearer $token'
      },
      {},
    );
    if (response.statusCode != 200) throw http.ClientException("");
  }

  Future<void> registerRide(
    String fromUri,
    String toUri,
    String date,
    String passengers,
    String time,
    String price,
    String description,
    String carModel,
    String carColor,
    String carPlate,
  ) async {
    registering = true;
    await registerPlace(fromUri);
    await registerPlace(toUri);
    final token = await persistentSecuredStorage.read(key: 'token');
    http.Response response = await request(
      RequestType.post,
      "/ride",
      <String, dynamic>{
        "from_place_id": fromUri,
        "to_place_id": toUri,
        "year": date.split('/')[2],
        "month": date.split('/')[1],
        "day": date.split('/')[0],
        "passengers" : passengers,
        "hours" : time.split(':')[0],
        "minutes": time.split(':')[1],
        "price" : price,
        "description": description,
        "car_model" : carModel,
        "car_color" : carColor,
        "car_plate" : carPlate
      },
      {
        'Authorization': 'Bearer $token'
      },
      {},
    );
    if (response.statusCode != 200) throw http.ClientException("");
    registering = false;
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    final token = await persistentSecuredStorage.read(key: 'token');
    http.Response response = await request(RequestType.get, '/user/me', {}, {
      'Authorization': 'Bearer $token',
    }, {});
    if (response.statusCode != 200) throw http.ClientException("");
    return jsonDecode(response.body);
  }

  Future<void> updateUserProfile(
    String phone,
    String name,
    String surname,
    String birth,
  ) async {
    Map<String, dynamic> userData = await hamsafarApiClient.getUserProfile();
    final token = await persistentSecuredStorage.read(key: 'token');
    http.Response response = await request(
      RequestType.put,
      "/user",
      {
        "phone": phone.isEmpty ? userData['phone'] : phone,
        "name": name.isEmpty ? userData['name'] : name,
        "surname": surname.isEmpty ? userData['surname'] : surname,
        "birth": birth.isEmpty ? userData['birth'] : birth,
      },
      {'Authorization': 'Bearer $token'},
      {},
    );
    if (response.statusCode != 200) throw http.ClientException("");
  }

  Future<List<Map<String, dynamic>>?> searchRides(
    String from,
    String to,
    String date,
    int passengers,
  ) async {
    final token = await persistentSecuredStorage.read(key: 'token');
    http.Response response = await request(
      RequestType.get,
      '/rides/search',
      {
        'from': from,
        'to': to,
        'date': date,
        'passengers': passengers.toString(),
      },
      {'Authorization': 'Bearer $token'},
      {},
    );
    final body = jsonDecode(response.body);
    if (body is List) {
      return body.cast<Map<String, dynamic>>();
    } else {
      return null;
    }
  }
}

var hamsafarApiClient = HamsafarApiClient();
