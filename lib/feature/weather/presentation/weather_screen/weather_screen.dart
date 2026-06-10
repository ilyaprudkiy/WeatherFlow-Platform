import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/app_bar_widget.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/card_current_weather.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/daily_forecast_widget.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/gradient_weather_screen_widget.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/hourly_forecast_widget.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/monthly_forecast_button.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/weather_bottom_nav_bar.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/weather_metrics_card_widget.dart';
import 'package:weather_app/navigation/navigation.dart';
import '../../../../core/add_images/images.dart';
import 'cubit/weather_screen_cubit.dart';

class WeatherScreenWidget extends StatelessWidget {
  const WeatherScreenWidget({super.key});

  static const _heroHeight = 400.0;

  @override
  Widget build(BuildContext context) {
    final weatherCubit = context.read<WeatherScreenCubit>();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is NotAuthorizedState) {
          Navigator.of(context).pushReplacementNamed(
            MainNavigationRouteNames.welcomeScreen,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: const WeatherBottomNavBar(),
        body: SafeArea(
          child: BlocConsumer<WeatherScreenCubit, WeatherScreenState>(
            listenWhen: (prev, curr) =>
                curr.showNotificationWindow && !prev.showNotificationWindow ||
                (curr.error != null && curr.error != prev.error),
            listener: (context, state) {
              if (state.showNotificationWindow) {
                _showGeoDialog(context, weatherCubit);
              } else if (state.error != null && state.currentWeather != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error!)),
                );
              }
            },
            builder: (context, state) {
              if (state.isLoading && state.currentWeather == null) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.currentWeather == null) {
                return const SizedBox.shrink();
              }

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: _heroHeight,
                      width: double.infinity,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              AppImages.backgroundWeather,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                          const Positioned.fill(
                            child: GradientWeatherScreenWidget(),
                          ),
                          const Positioned(
                            left: 20,
                            right: 20,
                            bottom: 8,
                            child: WeatherMetricsCardWidget(),
                          ),
                          const Positioned(
                            top: 8,
                            left: 0,
                            right: 0,
                            child: TopAppBarWidget(),
                          ),
                          Positioned(
                            top: 72,
                            left: 24,
                            right: 24,
                            child: CardCurrentWeatherWidget(
                              cityName: state.currentWeather!.cityName,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 48, 16, 80),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          HourlyForecastWidget(),
                          SizedBox(height: 24),
                          DailyForecastWidget(),
                          SizedBox(height: 20),
                          const MonthlyForecastButton(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _showGeoDialog(BuildContext context, WeatherScreenCubit weatherCubit) {
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Geodata request'),
        content: const Text(
          'Do you give permission to receive your geodata?',
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  weatherCubit.getWeatherByGeo();
                },
                child: const Text('Yes'),
              ),
              const SizedBox(width: 12),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  weatherCubit.getDefaultCityWeather();
                },
                child: const Text('No'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TemperatureWidget extends StatelessWidget {
  final String? temp;

  const TemperatureWidget({super.key, required this.temp});

  @override
  Widget build(BuildContext context) {
    return Text(
      temp ?? '',
      style: GoogleFonts.aBeeZee(
        color: Colors.white,
        fontSize: 64,
        fontWeight: FontWeight.w400,
        height: 1,
      ),
    );
  }
}
