// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:clean_architecture_forcast_weather/core/resources/data_state.dart';
import 'package:clean_architecture_forcast_weather/features/weather/data/datasources/remote/api_provider.dart';
import 'package:clean_architecture_forcast_weather/features/weather/data/models/current_city_model.dart';
import 'package:clean_architecture_forcast_weather/features/weather/domain/entities/current_city_entity.dart';
import 'package:clean_architecture_forcast_weather/features/weather/domain/repositories/waether_repository.dart';
import 'package:dio/dio.dart';

class WeatherRepositoryImp extends WeatherRepository {
  ApiProvider apiProvider;
  WeatherRepositoryImp({
    required this.apiProvider,
  });
  @override
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(
      String cityName) async {
    try {
      Response response = await apiProvider.callCurrentWeather(cityName);
      if (response.statusCode == 200) {
        CurrentCityEntity currentCityEntity =
            CurrentCityModel.fromJson(response.data);
        return DataSucces(currentCityEntity);
      } else {
        return const DataFailure('Something Went Wrong');
      }
    } catch (error) {
      return const DataFailure('please check your connection');
    }
  }
}
