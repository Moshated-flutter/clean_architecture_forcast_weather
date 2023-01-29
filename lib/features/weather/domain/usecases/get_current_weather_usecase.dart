import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/current_city_entity.dart';
import '../repositories/waether_repository.dart';

class GetCurrentWeatherUsecase
    extends Usecase<DataState<CurrentCityEntity>, String> {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUsecase(this.weatherRepository);

  @override
  Future<DataState<CurrentCityEntity>> call(String cityName) {
    return weatherRepository.fetchCurrentWeatherData(cityName);
  }
}
