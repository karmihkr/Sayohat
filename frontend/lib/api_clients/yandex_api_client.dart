import 'dart:convert';
import 'dart:ui';

import 'package:http/http.dart' as http;
import 'package:sayohat/project_settings.dart';

import '../models/place_model.dart';

class YandexApiClient {
  final client = http.Client();
  Locale? currentLocale;

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
          "lang": currentLocale!.languageCode == "uk"
              ? "tg"
              : currentLocale!.languageCode,
          "results": resultsCount,
          "highlight": highlightingMatches,
        },
      ),
    );
  }

  Future<http.Response> geocodeRequest(Map<String, dynamic> params, {useLocale = true}) {
    return client.get(
      Uri.https(
        projectSettings.yandexGeocoderApiUrl,
        projectSettings.yandexGeocoderApiGeocoderEndpoint,
        {
          ...params,
          "apikey": projectSettings.yandexGeocoderApiAccessToken,
          "lang": useLocale ? (currentLocale!.languageCode == "uk"
              ? "tg"
              : currentLocale!.languageCode) : "en",
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
    for (final component in firstGeoObject(
      response,
    )["metaDataProperty"]["GeocoderMetaData"]["Address"]["Components"]) {
      if (component["kind"] == "country") {
        country = component["name"];
        break;
      }
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
        suggesting = false;
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
      suggesting = false;
      return;
    }
    if (delayedRequest.isNotEmpty) {
      await suggestCities(delayedRequest);
    } else {
      suggesting = false;
    }
  }

  Future<void> suggestStreets(String incompleteStreet) async {
    suggesting = true;
    delayedRequest = "";
    suggested = [];
    try {
      http.Response response = await suggestRequest({
        "text": incompleteStreet,
        "types": "street,house,entrance",
        "attrs": "uri",
      });
      if (response.statusCode != 200) throw http.ClientException("");
      if (jsonDecode(response.body)["results"] == null) {
        suggested.add(Place(title: "No such streets", subtitle: "City"));
        suggesting = false;
        return;
      }
      for (final result in jsonDecode(response.body)["results"]) {
        suggested.add(
          Place(
            title: result["title"]["text"],
            subtitle: incompleteStreet.split(',')[1],
            uri: result["uri"],
          ),
        );
      }
    } catch (error) {
      suggested.add(
        Place(title: "Error occurred", subtitle: "Check internet connection"),
      );
      suggesting = false;
      return;
    }
    if (delayedRequest.isNotEmpty) {
      await suggestStreets(delayedRequest);
    } else {
      suggesting = false;
    }
  }

  dynamic firstGeoObject(http.Response response) {
    return jsonDecode(
      response.body,
    )["response"]["GeoObjectCollection"]["featureMember"][0]["GeoObject"];
  }

  Future<Map<String, dynamic>> geoInformationByUri(String uri) async {
    http.Response response = await geocodeRequest({"uri": uri}, useLocale: false);
    if (response.statusCode != 200) throw http.ClientException("");
    List<String> latitudeLongitude = firstGeoObject(
      response,
    )["Point"]["pos"].split(' ');
    String? country;
    String? locality;
    String? street;
    String? house;
    String? entrance;
    for (final component in firstGeoObject(
      response,
    )["metaDataProperty"]["GeocoderMetaData"]["Address"]["Components"]) {
      if (component["kind"] == "country") {
        country = component["name"];
      } else if (component["kind"] == "locality") {
        locality = component["name"];
      } else if (component["kind"] == "street") {
        street = component["name"];
      } else if (component["kind"] == "house") {
        house = component["name"];
      } else if (component["kind"] == "entrance") {
        entrance = component["name"];
      }
    }
    return {
      "longitude": latitudeLongitude[0],
      "latitude": latitudeLongitude[1],
      "country": country,
      "city": locality,
      "street": street ?? house ?? entrance
    };
  }
}

var yandexApiClient = YandexApiClient();
