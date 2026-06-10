import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/app_bar_widget.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/card_current_weather.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/gradient_weather_screen_widget.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/lower_app_bar_widget.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/weather_detail_card_widget.dart';
import 'package:weather_app/navigation/navigation.dart';
import '../../../../core/add_images/images.dart';
import 'cubit/weather_screen_cubit.dart';

class WeatherScreenWidget extends StatelessWidget {
  const WeatherScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final weatherCubit = context.read<WeatherScreenCubit>();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is NotAuthorizedState) {
          Navigator.of(context).pushReplacementNamed(
            MainNavigationRouteNames.welcomeScreen,
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFDCE6F0),
          bottomNavigationBar: LowerAppBarWidget(),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: BlocConsumer<WeatherScreenCubit, WeatherScreenState>(
              listener: (context, state) {
                if (state.showNotificationWindow == true) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Geodata request'),
                      content: const Text(
                        'Do you give permission to receive your geodata?',
                      ),
                      actions: [
                        Center(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FilledButton(
                                  style: FilledButton.styleFrom(
                                      backgroundColor: Colors.blueAccent),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    weatherCubit.getWeatherByGeo();
                                  },
                                  child: const Text('Yes'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FilledButton(
                                  style: FilledButton.styleFrom(
                                      backgroundColor: Colors.blueAccent),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    weatherCubit.getDefaultCityWeather();
                                  },
                                  child: const Text('No'),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state.isLoading == true) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.currentWeather != null) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: double.infinity,
                    child: Stack(children: [
                      Positioned(
                        bottom: 40,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          AppImages.backgroundWeather,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      GradientWeatherScreenWidget(),
                      const TopAppBarWidget(),
                      CardCurrentWeatherWidget(
                        cityName: state.currentWeather!.cityName,
                      ),
                      WeatherDetailCardWidget()
                    ]),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
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
      '$temp',
      style: GoogleFonts.aBeeZee(
        color: Colors.white,
        fontSize: 60,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
