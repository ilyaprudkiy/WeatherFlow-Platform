import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_icons_animated/weather_icons_animated.dart';
import '../cubit/weather_screen_cubit.dart';
import '../weather_screen.dart';

class CardCurrentWeatherWidget extends StatelessWidget {
  final String? cityName;

  const CardCurrentWeatherWidget({
    super.key,
    this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WeatherScreenCubit>();
    final minTemp = cubit.state.currentWeather!.minTemperatureRound;
    final maxTemp = cubit.state.currentWeather!.maxTemperatureRound;
    final feelsTempLike = cubit.state.currentWeather!.feelsTemperatureRound;
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(left: 40, top: 120),
            child: Row(
              children: [
                WeatherIcon(
                  icon: WeatherIcons.named('rain'),
                  width: 50,
                  height: 50,
                ),
                Text(
                  cityName!,
                  style: GoogleFonts.abrilFatface(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 180),
            child: TemperatureWidget(
              temp: cubit.state.currentWeather!.temperatureRound,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 180, bottom: 20),
            child: Text(
              'Fells like:${cubit.state.currentWeather!.feelsTemperatureRound}',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(bottom: 50),
            child: Container(
              child: TemperatureDetailWidget(
                wind: cubit.state.currentWeather!.windSpeed.toString(),
                humidity: cubit.state.currentWeather!.humidity.toString(),
                rain: '80%',
              ),
              width: 350,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: const Color(0xFF3D5873).withValues(alpha: 0.65),
                ),
                color: const Color(0xFF3D5873).withValues(alpha: 0.65),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TemperatureDetailWidget extends StatelessWidget {
  const TemperatureDetailWidget({
    super.key,
    required this.wind,
    required this.humidity,
    required this.rain,
  });

  final String wind;
  final String humidity;
  final String rain;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(
                Icons.water_drop_outlined,
                weight: 50,
              ),
              Column(
                children: [
                  Text(
                    'Humidity',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text('$humidity%'),
                ],
              ),
            ],
          ),
        ),
        VerticalDivider(
          width: 1,
          color: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              WeatherIcon(
                width: 50,
                height: 50,
                color: Colors.black45,
                icon: WeatherIcons.named('wind'),
              ),
              Column(
                children: [
                  Text(
                    'Wind',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(wind),
                ],
              ),
            ],
          ),
        ),
        VerticalDivider(
          width: 1,
          color: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            WeatherIcon(
              width: 50,
              height: 50,
              color: Colors.black45,
              icon: WeatherIcons.named('umbrella'),
            ),
            Column(
              children: [
                Text(
                  'Probability',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  rain,
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ],
            )
          ]),
        )
      ],
    );
  }
}
