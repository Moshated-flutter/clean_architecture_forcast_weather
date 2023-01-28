import 'package:clean_architecture_forcast_weather/core/resources/data_state.dart';
import 'package:clean_architecture_forcast_weather/features/weather/domain/entities/current_city_entity.dart';

abstract class WeatherRepository {
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String cityName);
}
