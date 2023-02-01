import 'package:clean_architecture_forcast_weather/core/resources/forcast_params.dart';
import 'package:dio/dio.dart';

import '../../../../../core/utils/constants.dart';

class ApiProvider {
  final Dio _dio = Dio();

  var apiKey = Constants.apiKey;

  /// current api weather call
  Future<dynamic> callCurrentWeather(String cityName) async {
    var respones = await _dio
        .get(Constants.baseUrl + '/data/2.5/weather', queryParameters: {
      'q': cityName,
      'appid': apiKey,
      'units': 'metric',
    });
    print(respones.data);
    return respones;
  }

  Future<dynamic> sendRequest7Days(ForcastParams params) async {
    var response = await _dio
        .get('${Constants.baseUrl}/data/2.5/forcast/daily', queryParameters: {
      'lat': params.lat,
      'lon': params.lon,
      'exclude': 'minutley,hourly',
      'appid': apiKey,
      'units': 'metric'
    });
    return response;
  }
}
