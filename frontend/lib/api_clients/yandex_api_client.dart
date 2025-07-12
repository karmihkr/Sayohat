import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sayohat/project_settings.dart';
import 'package:sayohat/screens/tabs-main-screens/add-ride-screens/add_ride_screen.dart';

import '../models/place_model.dart';

class YandexApiClient {
  final client = http.Client();

  String highlightingMatches = '0';
  String resultsCount = '4';

  late List<Place> suggested;
  String delayedRequest = "";
  bool suggesting = false;

  Future<http.Response> suggestRequest(Map<String, dynamic> params) {
    return client.get(
      Uri.https(
        projectSettings.yandexSuggestApiUrl,
        projectSettings.yandexSuggestApiSuggestEndpoint,
        {
          ...params,
          "apikey": projectSettings.yandexSuggestApiAccessToken,
          "lang": loc.localeName == "uk" ? "tg" : loc.localeName,
          "results": resultsCount,
          "highlight": highlightingMatches,
        },
      ),
    );
  }

  Future<http.Response> geocodeRequest(Map<String, dynamic> params) {
    return client.get(
      Uri.https(
        projectSettings.yandexGeocoderApiUrl,
        projectSettings.yandexGeocoderApiGeocoderEndpoint,
        {
          ...params,
          "apikey": projectSettings.yandexGeocoderApiAccessToken,
          "lang": loc.localeName == "uk" ? "tg" : loc.localeName,
          "results": '1',
          "format": "json",
        },
      ),
    );
  }

  Future<String> countryNameByUri(String uri) async {
    http.Response response = await geocodeRequest({"uri": uri});
    if (response.statusCode != 200) throw http.ClientException("");
    String? country;
    for (final component in jsonDecode(
      response.body,
    )["response"]["GeoObjectCollection"]["featureMember"][0]["GeoObject"]["metaDataProperty"]["GeocoderMetaData"]["Address"]["Components"]) {
      if (component["kind"] == "country") country = component["name"];
    }
    if (country == null) throw http.ClientException("");
    return country;
  }

  Future<void> suggestCities(String incompleteCity) async {
    suggesting = true;
    delayedRequest = "";
    suggested = [];
    try {
      http.Response response = await suggestRequest({
        "text": incompleteCity,
        "types": "locality",
        "attrs": "uri",
      });
      if (response.statusCode != 200) throw http.ClientException("");
      if (jsonDecode(response.body)["results"] == null) {
        suggested.add(Place(title: "No such localities", subtitle: "Country"));
        return;
      }
      for (final result in jsonDecode(response.body)["results"]) {
        suggested.add(
          Place(
            title: result["title"]["text"],
            subtitle: await countryNameByUri(result["uri"]),
          ),
        );
      }
    } catch (_) {
      suggested.add(
        Place(title: "Error occurred", subtitle: "Check internet connection"),
      );
      return;
    }
    if (delayedRequest.isNotEmpty) {
      await suggestCities(delayedRequest);
    } else {
      suggesting = false;
    }
  }
}

var yandexApiClient = YandexApiClient();
