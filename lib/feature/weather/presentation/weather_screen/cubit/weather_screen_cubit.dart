import 'package:bloc/bloc.dart';
import 'package:weather_app/feature/weather/domain/entity/weather_entity.dart';
import 'package:weather_app/feature/weather/domain/use_cases/weather_use_case.dart';

class WeatherScreenState {
  final WeatherEntity? currentWeather;
  final String? error;
  final String? debugMessage;
  final bool showNotificationWindow;
  final bool isLoading;

  WeatherScreenState({
    this.isLoading = false,
    this.showNotificationWindow = false,
    this.debugMessage,
    this.currentWeather,
    this.error,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherScreenState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          showNotificationWindow == other.showNotificationWindow &&
          currentWeather == other.currentWeather &&
          debugMessage == other.debugMessage &&
          error == other.error;

  @override
  int get hashCode =>
      currentWeather.hashCode ^
      error.hashCode ^
      debugMessage.hashCode ^
      showNotificationWindow.hashCode ^
      isLoading.hashCode;

  WeatherScreenState copyWith(
      {WeatherEntity? currentWeather,
      String? error,
      String? debugMessage,
      bool? showNotificationWindow,
      bool? isLoading}) {
    return WeatherScreenState(
        isLoading: isLoading ?? this.isLoading,
        showNotificationWindow:
            showNotificationWindow ?? this.showNotificationWindow,
        debugMessage: debugMessage ?? this.debugMessage,
        currentWeather: currentWeather ?? this.currentWeather,
        error: error ?? this.error);
  }
}

class WeatherScreenCubit extends Cubit<WeatherScreenState> {
  final WeatherUseCase useCase;

  WeatherScreenCubit(this.useCase) : super(WeatherScreenState()) {
    Future.microtask(_showNotificationWindow);
  }

  void _showNotificationWindow() {
    if (state.currentWeather == null) {
      emit(state.copyWith(showNotificationWindow: true));
    }
  }

  void closNotificationWindow(){
    emit(state.copyWith(showNotificationWindow: false));
  }

  void getWeatherByName(String city) async {
    final result = await useCase.getWeatherByCityName(city);
    result.fold((failure) {
      emit(state.copyWith(
          error: failure.message,
          debugMessage: 'WeatherCubit.weatherByCityName'));
    }, (weather) {
      emit(state.copyWith(currentWeather: weather));
    });
  }

  void getWeatherByGeo() async {
    emit(state.copyWith(
      isLoading: true,
      showNotificationWindow: false,
      error: null,
    ));

    final result = await useCase.getWeatherByGeo();

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          error: failure.message,
          debugMessage: 'WeatherCubit.weatherByGeo',
        ));
      },
      (weather) {
        emit(state.copyWith(
          isLoading: false,
          currentWeather: weather,
          showNotificationWindow: false,
          error: null,
        ));
      },
    );
  }

  void getDefaultCityWeather() async {
    emit(state.copyWith(showNotificationWindow: false, isLoading: true));
    final result = await useCase.getDefaultCityWeather();

    result.fold((failure) {
      emit(state.copyWith(
          isLoading: false,
          error: failure.message,
          debugMessage: 'WeatherCubit.defaultCityWeather'));
    }, (weather) {
      emit(state.copyWith(
          currentWeather: weather,
          isLoading: false,
          showNotificationWindow: false));
    });
  }
}
