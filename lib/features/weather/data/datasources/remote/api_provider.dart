import '../../../../../core/utils/constants.dart';
import 'package:dio/dio.dart';

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
}
