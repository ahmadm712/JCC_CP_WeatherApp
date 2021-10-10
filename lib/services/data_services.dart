import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/models/models.dart';

class DataService {
  Future<WeatherResponse> getWeather(String city) async {
    // api key
    // 83514edefbb2d02aa27bdd66a9f436be
    // api.openweathermap.org/data/2.5/forecast?q={city name}&appid={API key}

    final queryParameter = {
      'q': city,
      'appid': '83514edefbb2d02aa27bdd66a9f436be',
      'units': 'imperial'
    };
    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameter);

    final response = await http.get(uri);

    print(response.body);

    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}
