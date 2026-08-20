import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:weather_app/core/config/configuration/configuration.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'core/di/service_locator.dart';
import 'feature/auth/presentation/cubit/auth_cubit.dart';
import 'navigation/navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BootstrapApp());
}

class BootstrapApp extends StatefulWidget {
  const BootstrapApp({super.key});

  @override
  State<BootstrapApp> createState() => _BootstrapAppState();
}

class _BootstrapAppState extends State<BootstrapApp> {
  late final Future<void> _initFuture;

  Future<void> _init() async {
    await Supabase.initialize(
      url: Configuration.urlSupabase,
      anonKey: Configuration.anonKey,
    ).timeout(const Duration(seconds: 15));

    await initServiceLocator().timeout(const Duration(seconds: 5));
  }

  @override
  void initState() {
    super.initState();
    _initFuture = _init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Init error: ${snapshot.error}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        }
        return MultiBlocProvider(providers: [
          BlocProvider<AuthCubit>(
            create: (_) => sl<AuthCubit>(),
          )
        ], child: const MyApp());
      },
    );
  }
}

class MyApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      // Start = Welcome. Do not set `home` together with a '/' route.
      routes: mainNavigation.routes,
      initialRoute: MainNavigationRouteNames.welcomeScreen,
    );
  }
}
