import 'package:get_it/get_it.dart';
import 'package:weather_app/core/error/mappers/supabase_error_mapper.dart';
import 'package:weather_app/core/error/mappers/weather_error_mapper.dart';
import 'package:weather_app/core/supabase_client/supabase_client_provider.dart';
import 'package:weather_app/core/validators/auth_validator/auth_validator.dart';
import 'package:weather_app/feature/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:weather_app/feature/auth/data/data_sources/supabase_remote_data_source.dart';
import 'package:weather_app/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:weather_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:weather_app/feature/auth/domain/use_cases/auth_use_cases.dart';
import 'package:weather_app/feature/weather/data/api_client/weather_api_client.dart';
import 'package:weather_app/feature/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:weather_app/feature/weather/data/data_sources/weather_remote_data_source_impl.dart';
import 'package:weather_app/feature/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/feature/weather/domain/repository/weather_repository.dart';
import 'package:weather_app/feature/weather/domain/use_cases/weather_use_case.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/cubit/weather_screen_cubit.dart';
import '../../feature/auth/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  sl.registerFactory<AuthCubit>(() => AuthCubit(
        sl<AuthUseCase>(),
      ));

  sl.registerLazySingleton<AuthUseCase>(
      () => AuthUseCase(sl<AuthRepository>(), sl<AuthValidator>()));
  sl.registerLazySingleton(() => AuthValidator());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        sl<AuthRemoteDataSource>(),
        sl<SupabaseErrorMapper>(),
      ));

  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => SupabaseRemoteDataSource(sl<SupabaseClientProvider>()));
  sl.registerLazySingleton(() => SupabaseClientProvider());
  sl.registerLazySingleton(() => SupabaseErrorMapper());

  sl.registerFactory<WeatherScreenCubit>(() => WeatherScreenCubit(
        sl<WeatherUseCase>(),
      ));
  sl.registerLazySingleton<WeatherUseCase>(() => WeatherUseCase(
        sl<WeatherRepository>(),
      ));
  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
      sl<WeatherRemoteDataSource>(), sl<WeatherErrorMapper>()));
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(sl<WeatherApiClient>()));
  sl.registerLazySingleton(() => WeatherErrorMapper());
  sl.registerLazySingleton(() => WeatherApiClient());
}
