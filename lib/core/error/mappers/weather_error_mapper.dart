import 'dart:async';
import 'dart:io';

import 'package:weather_app/core/error/failure/failure.dart';

class WeatherErrorMapper {
  Failure map(Object e, {String? context}) {
    if (e is SocketException) {
      return NetworkFailure('Нет подключения к интернету',
          debugMessage: '${context ?? ''}$e');
    }
    if (e is TimeoutException) {
      return NetworkFailure('Превышено время ожидания', debugMessage: '${context ?? ''}$e');
    } else {
      return UnknownFailure('неизвестная ошибка', debugMessage: '${context ?? ''}$e');
    }
  }
}
