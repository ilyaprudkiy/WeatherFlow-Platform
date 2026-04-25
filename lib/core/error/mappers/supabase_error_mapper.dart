import 'dart:async';
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:weather_app/core/error/failure/failure.dart';

class SupabaseErrorMapper {
  Failure map(Object e, {String? context}) {
    if (e is SocketException) {
      return NetworkFailure('Нет подключения к интернету',
          debugMessage: '${context ?? ''}$e ');
    }
    if (e is TimeoutException) {
      return NetworkFailure('Привышено время ожидания',
          debugMessage: '${context ?? ''}$e');
    }
    if (e is AuthException) {
      final uiMes = _authUiMessage(e.message);
      return AuthFailure(uiMes, debugMessage: '${context ?? ''}${e.message}');
    }
    if (e is PostgrestException) {
      final uiMes = _postgresUiMessage(e);
      return ServerFailure(uiMes,
          debugMessage:
              '${context ?? ''} ${e.message} | ${e.details} |${e.hint}');
    } else {
      return UnknownFailure(('Неизвестная ошибка'),
          debugMessage: '${context ?? ''} $e');
    }
  }

  String _authUiMessage(String raw) {
    final mes = raw.toLowerCase();
    if (mes.contains('duplicate key')) return 'Такая запись уже существует';
    if (mes.contains('permission denied') ||
        mes.contains('new row violates row-level security')) {
      return 'Нет прав на выполнение операции';
    }
    return 'Ошибка сервера';
  }

  String _postgresUiMessage(PostgrestException e) {
    final mes = e.message.toLowerCase();
    if (mes.contains('duplicate key')) return 'Такая запись уже существует';
    if (mes.contains('permission denied') ||
        mes.contains('new row violates row-level security')) {
      return 'Нет прав на выполнение операции';
    }
    return 'Ошибка сервера';
  }
}
