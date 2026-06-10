import 'package:bloc/bloc.dart';
import 'package:weather_app/feature/weather/domain/entity/weather_daily_forecast_entity.dart';
import 'package:weather_app/feature/weather/domain/entity/weather_entity.dart';
import 'package:weather_app/feature/weather/domain/entity/weather_hours_entity.dart';
import 'package:weather_app/feature/weather/domain/use_cases/weather_use_case.dart';

class WeatherScreenState {
  final WeatherEntity? currentWeather;
  final WeatherHoursEntity? hourlyForecast;
  final WeatherDailyForecastEntity? dailyForecast;
  final String? error;
  final String? debugMessage;
  final bool showNotificationWindow;
  final bool isLoading;
  final int selectedHourIndex;

  WeatherScreenState({
    this.isLoading = false,
    this.showNotificationWindow = false,
    this.debugMessage,
    this.currentWeather,
    this.hourlyForecast,
    this.dailyForecast,
    this.error,
    this.selectedHourIndex = 0,
  });

  double? get todayUvIndex {
    final days = dailyForecast?.days;
    if (days == null || days.isEmpty) return null;
    return days.first.uvi;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherScreenState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          showNotificationWindow == other.showNotificationWindow &&
          selectedHourIndex == other.selectedHourIndex &&
          currentWeather == other.currentWeather &&
          hourlyForecast == other.hourlyForecast &&
          dailyForecast == other.dailyForecast &&
          debugMessage == other.debugMessage &&
          error == other.error;

  @override
  int get hashCode =>
      Object.hash(
        currentWeather,
        hourlyForecast,
        dailyForecast,
        error,
        debugMessage,
        showNotificationWindow,
        isLoading,
        selectedHourIndex,
      );

  WeatherScreenState copyWith({
    WeatherEntity? currentWeather,
    WeatherHoursEntity? hourlyForecast,
    WeatherDailyForecastEntity? dailyForecast,
    String? error,
    String? debugMessage,
    bool? showNotificationWindow,
    bool? isLoading,
    int? selectedHourIndex,
    bool clearError = false,
  }) {
    return WeatherScreenState(
      isLoading: isLoading ?? this.isLoading,
      showNotificationWindow:
          showNotificationWindow ?? this.showNotificationWindow,
      debugMessage: debugMessage ?? this.debugMessage,
      currentWeather: currentWeather ?? this.currentWeather,
      hourlyForecast: hourlyForecast ?? this.hourlyForecast,
      dailyForecast: dailyForecast ?? this.dailyForecast,
      error: clearError ? null : (error ?? this.error),
      selectedHourIndex: selectedHourIndex ?? this.selectedHourIndex,
    );
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

  void closNotificationWindow() {
    emit(state.copyWith(showNotificationWindow: false));
  }

  void selectHour(int index) {
    emit(state.copyWith(selectedHourIndex: index));
  }

  Future<void> getWeatherByName(String city) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final result = await useCase.getWeatherByCityName(city);
    result.fold((failure) {
      emit(state.copyWith(
        isLoading: false,
        error: failure.message,
        debugMessage: 'WeatherCubit.weatherByCityName',
      ));
    }, (weather) async {
      emit(state.copyWith(
        isLoading: false,
        currentWeather: weather,
        showNotificationWindow: false,
      ));
      await _loadForecasts(weather.lat, weather.lon);
    });
  }

  Future<void> getWeatherByGeo() async {
    emit(state.copyWith(
      isLoading: true,
      showNotificationWindow: false,
      clearError: true,
    ));

    final result = await useCase.getWeatherByGeo();

    await result.fold(
      (failure) async {
        emit(state.copyWith(
          isLoading: false,
          error: failure.message,
          debugMessage: 'WeatherCubit.weatherByGeo',
        ));
      },
      (weather) async {
        emit(state.copyWith(
          isLoading: false,
          currentWeather: weather,
          showNotificationWindow: false,
        ));
        await _loadForecasts(weather.lat, weather.lon);
      },
    );
  }

  Future<void> getDefaultCityWeather() async {
    emit(state.copyWith(
      showNotificationWindow: false,
      isLoading: true,
      clearError: true,
    ));

    final result = await useCase.getDefaultCityWeather();

    await result.fold(
      (failure) async {
        emit(state.copyWith(
          isLoading: false,
          error: failure.message,
          debugMessage: 'WeatherCubit.defaultCityWeather',
        ));
      },
      (weather) async {
        emit(state.copyWith(
          currentWeather: weather,
          isLoading: false,
          showNotificationWindow: false,
        ));
        await _loadForecasts(weather.lat, weather.lon);
      },
    );
  }

  Future<void> _loadForecasts(double lat, double lon) async {
    final hoursResult = await useCase.getWeatherHours(lat, lon);
    final dailyResult = await useCase.getWeatherDaily(lat, lon);

    hoursResult.fold(
      (failure) => emit(state.copyWith(
        error: failure.message,
        debugMessage: 'WeatherCubit.loadHours',
      )),
      (hours) => emit(state.copyWith(hourlyForecast: hours)),
    );

    dailyResult.fold(
      (failure) => emit(state.copyWith(
        error: failure.message,
        debugMessage: 'WeatherCubit.loadDaily',
      )),
      (daily) => emit(state.copyWith(dailyForecast: daily)),
    );
  }
}
