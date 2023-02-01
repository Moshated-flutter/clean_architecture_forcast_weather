import 'package:bloc/bloc.dart';
import '../../../../core/resources/data_state.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_current_weather_usecase.dart';
import 'cw_status.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUsecase getCurrentWeatherUsecase;
  WeatherBloc(this.getCurrentWeatherUsecase)
      : super(WeatherState(
          cwStatus: CwLoading(),
        )) {
    on<LoadCwEvent>((event, emit) async {
      emit(state.copyWith(newCwStatus: CwLoading()));
      DataState dataState = await getCurrentWeatherUsecase(event.cityName);
      if (dataState is DataSucces) {
        emit(state.copyWith(newCwStatus: CwComplited(dataState.data)));
        print(dataState.data);
      }
      if (dataState is DataFailure) {
        emit(state.copyWith(newCwStatus: CwError(dataState.error!)));
      }
    });
  }
}
