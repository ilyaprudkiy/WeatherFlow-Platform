import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:weather_app/navigation/navigation.dart';
import 'cubit/weather_screen_cubit.dart';

class WeatherScreenWidget extends StatelessWidget {
  const WeatherScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Scaffold(
      floatingActionButton: ElevatedButton(
          onPressed: () {
            cubit.logout();
            if (cubit.state is NotAuthorizedState) {
              Navigator.of(context)
                  .pushReplacementNamed(MainNavigationRouteNames.welcomeScreen);
            }
          },
          child: Text('Logout')),
      body: SingleChildScrollView(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(children: [
          Image.network(
              'https://media.istockphoto.com/id/2060491755/de/foto/sky-landscapes-collage-weather-forecast-global-warming-climate-change-support-environmental.jpg?s=2048x2048&w=is&k=20&c=O_KuckWo4nWNqvDy_hrNWRToZuUdKKkuDxiV3zpGZ4E='),
          ListView(children: const [
            Column(
              children: [
                AppBarWidget(),
                Padding(
                    padding: EdgeInsets.all(10), child: TemperatureWidget()),
              ],
            )
          ]),
        ]),
      )),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<WeatherScreenCubit>();
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 40, right: 10),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(13)),
                child: const Icon(
                  Icons.menu,
                  color: Colors.grey,
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(left: 10, top: 40, right: 20),
              child: CurrentCityWidget(cubit: cubit))
        ]);
  }
}

class CurrentCityWidget extends StatelessWidget {
  const CurrentCityWidget({
    super.key,
    required this.cubit,
  });

  final WeatherScreenCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: 250,
        child: TextField(
          onTap: () {},
          readOnly: true,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 25),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              // hintText: cubit.state.cities[0].name,
              hintStyle: const TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              suffixIcon: const Icon(Icons.my_location_outlined)),
        ));
  }
}

class TemperatureWidget extends StatelessWidget {
  const TemperatureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text.rich(
      TextSpan(
        text: '23',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: '°C',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
