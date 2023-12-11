import 'dart:convert';

import 'weather.dart';


import 'package:http/http.dart' as http;

import 'config.dart';

// void main(List<String> arguments) {
//   final getCityApi = getCityClass();
//   getCityApi.getCityName(String cityName);
// }

class getCityClass {
  Future getCityName(String cityName) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$cityName&key=AIzaSyDJ-biU5k2YpGbhlB7kNTl9RQaseN8uzuM';
    print(url);

    final response = await http.get(Uri.parse(url));
    // print(response.body);

    if (response.statusCode != 200) {
      print('Request failed with status: ${response.statusCode}');
    }

    final Map<String, dynamic> jsonResponse =
        Map.castFrom(jsonDecode(response.body));

    List<dynamic> predictionList = jsonResponse['predictions'];
    String cityID;

    for (var pre in predictionList) {
      String desc = pre['description'];

      if (desc.contains('Kazakhstan')) {
        String place_id = pre['place_id'];

        print('placeId: $place_id');
        getCityDetails(place_id: place_id);
      }
    }
  }

  void getCityDetails({final place_id}) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$place_id&key=AIzaSyDJ-biU5k2YpGbhlB7kNTl9RQaseN8uzuM';
    print(url);

    final response = await http.get(Uri.parse(url));

    final Map<String, dynamic> jsonResponse =
        Map.castFrom(jsonDecode(response.body));

    final Map<String, dynamic> resultMap = jsonResponse['result'];
    String placeUrl = resultMap['url'];
    print('Place URL: $placeUrl');
  }
}

