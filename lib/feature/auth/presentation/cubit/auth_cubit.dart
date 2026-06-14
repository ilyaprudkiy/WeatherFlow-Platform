import 'package:bloc/bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:weather_app/feature/auth/domain/use_cases/auth_use_cases.dart';
import '../../../../core/result/result.dart';

abstract class AuthState {}

class LoadingState extends AuthState {}

class AuthorizedState extends AuthState {}

class NotAuthorizedState extends AuthState {}

class UnknownState extends AuthState {}

class ErrorState extends AuthState {
  final String message;
  final String debugMessage;

  ErrorState(this.message, this.debugMessage);
}

class AuthCubit extends Cubit<AuthState> {
  final AuthUseCase useCase;

  AuthCubit(this.useCase) : super(UnknownState()) {
    Future.microtask(_onState);
  }

  Session? _getSession() {
    final session = useCase.getCurrentSession();
    return session;
  }

  void _onState() async {
    try {
      final session = _getSession();
      if (session != null) {
        emit(AuthorizedState());
      } else {
        emit(NotAuthorizedState());
      }
    } catch (_) {
      emit(ErrorState('Error', 'AuthCubit.onState'));
    }
  }

  Future<void> signUp(
      String email, String password, String repeatPassword) async {
    emit(LoadingState());
    final res = await useCase.signUp(
        password: password, email: email, repeatPassword: repeatPassword);
    switch (res) {
      case Ok():
        emit(AuthorizedState());
      case Err():
        emit(ErrorState(res.failure.message, 'AuthCubit.signUp'));
    }
  }

  Future<void> login(String email, String password) async {
    emit(LoadingState());
    final res = await useCase.login(password: password, email: email);
    switch (res) {
      case Ok():
        emit(AuthorizedState());
      case Err():
        emit(ErrorState(res.failure.message, 'AuthCubit.login'));
    }
  }

  Future<void> logout() async {
    final session = _getSession();
    if (session != null) {
      final res = await useCase.logout();

      switch (res) {
        case Ok():
          emit(NotAuthorizedState());
        case Err():
          emit(ErrorState(res.failure.message, 'AuthCubit.logout'));
      }
    }
  }
}
