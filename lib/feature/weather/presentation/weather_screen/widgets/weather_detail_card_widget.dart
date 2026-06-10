import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/cubit/weather_screen_cubit.dart';

class WeatherDetailCardWidget extends StatelessWidget {
  const WeatherDetailCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WeatherScreenCubit>();
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 250, // фиксированная высота нижнего меню
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(30),
          children: [
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CardHoursWidget(cubit: cubit),
                  CardHoursWidget(cubit: cubit),
                  CardHoursWidget(cubit: cubit),
                  CardHoursWidget(cubit: cubit),
                  CardHoursWidget(cubit: cubit),
                  CardHoursWidget(cubit: cubit),
                  CardHoursWidget(cubit: cubit),
                  CardHoursWidget(cubit: cubit),
                  CardHoursWidget(cubit: cubit),
                  CardHoursWidget(cubit: cubit),
                  CardHoursWidget(cubit: cubit),
                  CardHoursWidget(cubit: cubit),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(height: 200, color: Colors.grey),
            const SizedBox(height: 20),
            Container(height: 200, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class CardHoursWidget extends StatelessWidget {
  const CardHoursWidget({
    super.key,
    required this.cubit,
  });

  final WeatherScreenCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white60,
        border: BoxBorder.all(),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.cloud,
          ),
          Text(
            '${cubit.state.currentWeather!.feelsTemperatureRound}',
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
