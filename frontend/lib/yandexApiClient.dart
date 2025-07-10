import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sayohat/project_settings.dart';
import 'package:yandex_maps_mapkit/mapkit.dart';
import 'package:yandex_maps_mapkit/search.dart';

class YandexAPIClient {
  SearchSession? session;

  Future<SearchResponse> searchToponyms(String request, Point near) {
    final searchManager = SearchFactory.instance.createSearchManager(SearchManagerType.Online);
    final completer = Completer<SearchResponse>();
    final searchOptions = SearchOptions(
        searchTypes: SearchType.Geo,
        resultPageSize: 5
    );
    print("banana");
    session = searchManager.submit(
        Geometry.fromPoint(near),
        searchOptions,
        SearchSessionSearchListener(
          onSearchResponse: (SearchResponse response) {
            print("strawberry");
            if (!completer.isCompleted) {
              completer.complete(response);
            }
          },
          onSearchError: (error) {
            print("raspberry");
            if (!completer.isCompleted) {
              completer.completeError(
                Exception("Failed: ${error.runtimeType}")
              );
            }
          }
        ),
        text: request
    );
    return completer.future;
  }

}

var yandexApiClient = YandexAPIClient();
