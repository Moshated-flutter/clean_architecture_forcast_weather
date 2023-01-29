import 'package:clean_architecture_forcast_weather/features/weather/data/datasources/remote/api_provider.dart';
import 'package:clean_architecture_forcast_weather/features/weather/data/repositories/waether_repository_imp.dart';
import 'package:clean_architecture_forcast_weather/features/weather/domain/repositories/waether_repository.dart';
import 'package:clean_architecture_forcast_weather/features/weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:clean_architecture_forcast_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setup() {
  // api provider
  locator.registerSingleton<ApiProvider>(ApiProvider());

  // repositories
  locator.registerSingleton<WeatherRepository>(
      WeatherRepositoryImp(apiProvider: locator()));

  // use cases
  locator.registerSingleton<GetCurrentWeatherUsecase>(
      GetCurrentWeatherUsecase(locator()));

  //bloc
  locator.registerSingleton<WeatherBloc>(WeatherBloc(locator()));
}
