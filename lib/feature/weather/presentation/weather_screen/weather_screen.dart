import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/navigation/auth_navigation.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/widgets/app_snackbar.dart';
import 'package:weather_app/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/app_bar_widget.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/card_current_weather.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/daily_forecast_widget.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/geo_permission_dialog.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/gradient_weather_screen_widget.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/hourly_forecast_widget.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/monthly_forecast_button.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/weather_bottom_nav_bar.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/weather_metrics_card_widget.dart';
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
          navigateToWelcome(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffold,
        bottomNavigationBar: const WeatherBottomNavBar(),
        body: SafeArea(
          child: BlocConsumer<WeatherScreenCubit, WeatherScreenState>(
            listenWhen: (prev, curr) =>
                curr.showNotificationWindow && !prev.showNotificationWindow ||
                (curr.error != null && curr.error != prev.error),
            listener: (context, state) {
              if (state.showNotificationWindow) {
                showGeoPermissionDialog(context, weatherCubit);
              } else if (state.error != null && state.currentWeather != null) {
                context.showAppSnackBar(state.error!);
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
                          MonthlyForecastButton(),
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
}
