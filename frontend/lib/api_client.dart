import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sayohat/project_settings.dart';

class APIClient {
  var client = http.Client();
  var get = "get";
  var post = "post";
  var delete = "delete";
  var put = "put";

  Future<http.Response> request(
    String type,
    String endpoint,
    Map<String, dynamic> params,
    Map<String, String> headers,
  ) {
    return (type == get
        ? client.get
        : type == post
        ? client.post
        : type == delete
        ? client.delete
        : client.put)(
      (projectSettings.localHosted ? Uri.http : Uri.https)(
        projectSettings.apiUrl,
        endpoint,
        params,
      ),
      headers: headers,
    );
  }

  Future<http.Response> sideRequest(
    String type,
    String url,
    String endpoint,
    Map<String, dynamic> params,
    Map<String, String> headers,
  ) {
    return (type == get
        ? client.get
        : type == post
        ? client.post
        : type == delete
        ? client.delete
        : client.put)(Uri.https(url, endpoint, params), headers: headers);
  }

  Future<bool> checkTokenActuality(String? token) async {
    if (token == null) {
      return false;
    }
    http.Response? response;
    try {
      response = await request(post, "/hello", <String, dynamic>{}, {
        "Authorization": "Bearer $token",
      });
    } finally {
      return response?.statusCode == 200;
    }
  }

  Future<String> vericodeRequestId(String number) async {
    http.Response? response;
    try {
      response = await sideRequest(
        post,
        projectSettings.telegramApiUrl,
        projectSettings.telegramApiSendEndpoint,
        <String, dynamic>{"phone_number": number, "code_length": "4"},
        <String, String>{
          "Authorization": "Bearer ${projectSettings.telegramApiAccessToken}",
          "Content-Type": "application/json",
        },
      );
    } finally {
      if (response?.statusCode != 200) {
        return "unsent";
      }
      var jsonResponse = jsonDecode(response!.body);
      if (!jsonResponse["ok"]) {
        return "unsent";
      }
      jsonResponse = jsonResponse["result"];
      if (jsonResponse["delivery_status"]["status"] != "sent") {
        return "unsent";
      } else {
        return jsonResponse["request_id"];
      }
    }
  }

  Future<bool?> checkVericode(String requestId, String code) async {
    http.Response? response;
    try {
      response = await sideRequest(
        post,
        projectSettings.telegramApiUrl,
        projectSettings.telegramApiCheckEndpoint,
        <String, dynamic>{"request_id": requestId, "code": code},
        <String, String>{
          "Authorization": "Bearer ${projectSettings.telegramApiAccessToken}",
          "Content-Type": "application/json",
        },
      );
    } finally {
      if (response?.statusCode != 200) {
        return null;
      }
      var jsonResponse = jsonDecode(response!.body);
      if (!jsonResponse["ok"]) {
        return null;
      }
      jsonResponse = jsonResponse["result"];
      if (jsonResponse["verification_status"]["status"] == "code_valid") {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<Map<String, dynamic>?> checkUsernameExistance(String phone) async {
    http.Response? response;
    try {
      response = await request(post, "/user_existence", <String, dynamic>{
        "phone": phone,
      }, <String, String>{});
    } finally {
      if (response?.statusCode != 200) {
        return null;
      }
      return jsonDecode(response!.body);
    }
  }

  Future<Map<String, dynamic>?> registerNewUser(
    String phone,
    String name,
    String surname,
    String birth,
  ) async {
    http.Response? response;
    try {
      response = await request(post, "/user", <String, dynamic>{
        "phone": phone,
        "name": name,
        "surname": surname,
        "birth": birth,
      }, <String, String>{});
    } finally {
      if (response?.statusCode != 200) {
        return null;
      }
      return jsonDecode(response!.body);
    }
  }

  Future<Map<String, dynamic>?> getUserProfile() async {
    final token = await persistentSecuredStorage.read(key: 'token');
    http.Response? response;
    if (token == null) return null;
    try {
      response = await request(get, '/user/me', {}, {
        'Authorization': 'Bearer $token',
      });
    } finally {
      if (response?.statusCode != 200) {
        return null;
      }
      return jsonDecode(response!.body);
    }
  }

  Future<bool> updateUserProfile(
    String phone,
    String name,
    String surname,
    String birth,
  ) async {
    Map<String, dynamic>? userData = await apiClient.getUserProfile();
    final token = await persistentSecuredStorage.read(key: 'token');
    http.Response? response;
    if (token == null) return false;
    try {
      response = await request(
        put,
        "/user",
        <String, dynamic>{
          "phone": phone.isEmpty ? userData!['phone'] : phone,
          "name": name.isEmpty ? userData!['name'] : name,
          "surname": surname.isEmpty ? userData!['surname'] : surname,
          "birth": birth.isEmpty ? userData!['birth'] : birth,
        },
        {'Authorization': 'Bearer $token'},
      );
    } finally {
      if (response?.statusCode != 200) {
        return false;
      }
      return true;
    }
  }
}

var apiClient = APIClient();
