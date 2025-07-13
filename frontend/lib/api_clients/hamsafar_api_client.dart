import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:sayohat/api_clients/request_types.dart';
import 'package:sayohat/api_clients/yandex_api_client.dart';
import 'package:sayohat/objects/current_user.dart';
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

  Future<void> registerUser() async {
    registering = true;
    http.Response response = await request(
      RequestType.post,
      "/user",
      {
        "phone": currentUser.phone,
        "name": currentUser.name,
        "surname": currentUser.surname,
        "year": currentUser.year.toString(),
        "month": currentUser.month.toString(),
        "day": currentUser.day.toString()
      },
      {},
      {},
    );
    if (response.statusCode != 200) throw http.ClientException("");
    registering = false;
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

  Future<String> getUserProfile() async {
    final token = await persistentSecuredStorage.read(key: 'token');
    http.Response response = await request(RequestType.get, '/user/me', {}, {
      'Authorization': 'Bearer $token',
    }, {});
    if (response.statusCode != 200) throw http.ClientException("");
    return response.body;
  }

  Future<void> updateUserProfile(
    String phone,
    String name,
    String surname,
    String birth,
  ) async {
    final token = await persistentSecuredStorage.read(key: 'token');
    http.Response response = await request(
      RequestType.put,
      "/user",
      {
        "phone": phone.isEmpty ? currentUser.phone : phone,
        "name": name.isEmpty ? currentUser.name : name,
        "surname": surname.isEmpty ? currentUser.surname : surname,
        "year": birth.isEmpty ? currentUser.year.toString() : birth.split('/')[2],
        "month": birth.isEmpty ? currentUser.month.toString() : birth.split('/')[1],
        "day": birth.isEmpty ? currentUser.day.toString() : birth.split('/')[0],
      },
      {'Authorization': 'Bearer $token'},
      {},
    );
    if (response.statusCode != 200) throw http.ClientException("");
  }

  // should be refined
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

  Future<List<String>> getUserRides() async {
    final token = await persistentSecuredStorage.read(key: 'token');
    http.Response response = await request(
      RequestType.get,
      "/rides/${currentUser.id}",
      {},
      {'Authorization': 'Bearer $token'},
      {},
    );
    if (response.statusCode != 200) throw http.ClientException("");
    List<String> rides = [];
    for (final ride in jsonDecode(response.body)["rides"]) {
      rides.add(jsonEncode(ride));
    }
    return rides;
  }
}

var hamsafarApiClient = HamsafarApiClient();
