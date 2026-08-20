import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/di/service_locator.dart';
import 'package:weather_app/core/navigation/auth_navigation.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:weather_app/feature/city_search/domain/entity/city_weather_card_entity.dart';
import 'package:weather_app/feature/city_search/presentation/city_search_screen/city_search_screen.dart';
import 'package:weather_app/feature/city_search/presentation/city_search_screen/cubit/city_search_cubit.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/cubit/weather_screen_cubit.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/weather_screen.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/geo_permission_dialog.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/widgets/weather_bottom_nav_bar.dart';

class WeatherMainShell extends StatefulWidget {
  const WeatherMainShell({super.key});

  @override
  State<WeatherMainShell> createState() => _WeatherMainShellState();
}

class _WeatherMainShellState extends State<WeatherMainShell> {
  int _selectedTab = 0;
  bool _citySearchInitialized = false;
  bool _geoDialogOpen = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherScreenCubit>(
          create: (_) => sl<WeatherScreenCubit>(),
        ),
        BlocProvider<CitySearchCubit>(
          create: (_) => sl<CitySearchCubit>(),
        ),
      ],
      child: Builder(
        builder: (shellContext) {
          return BlocListener<AuthCubit, AuthState>(
            listenWhen: (_, state) => state is NotAuthorizedState,
            listener: (context, state) => navigateToWelcome(context),
            child: BlocListener<WeatherScreenCubit, WeatherScreenState>(
              listenWhen: (prev, curr) =>
                  curr.showNotificationWindow && !prev.showNotificationWindow,
              listener: (_, __) => _openGeoDialog(shellContext),
              child: Scaffold(
                backgroundColor: AppColors.scaffold,
                body: _buildTabBody(shellContext),
                bottomNavigationBar: WeatherBottomNavBar(
                  selectedIndex: _selectedTab,
                  onSelected: (index) => _onTabSelected(shellContext, index),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabBody(BuildContext shellContext) {
    switch (_selectedTab) {
      case 0:
        return const WeatherScreenWidget();
      case 1:
        return CitySearchScreen(
          onCitySelected: (card) => _onCitySelected(shellContext, card),
        );
      case 2:
        return const _ShellPlaceholder(title: 'Saved cities');
      case 3:
        return const _ShellPlaceholder(title: 'Forecast details');
      default:
        return const SizedBox.shrink();
    }
  }

  void _onTabSelected(BuildContext shellContext, int index) {
    setState(() => _selectedTab = index);

    if (index == 1 && !_citySearchInitialized) {
      _citySearchInitialized = true;
      shellContext.read<CitySearchCubit>().load();
    }
  }

  void _openGeoDialog(BuildContext shellContext) {
    if (_geoDialogOpen) return;
    _geoDialogOpen = true;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) {
        _geoDialogOpen = false;
        return;
      }

      final weatherCubit = shellContext.read<WeatherScreenCubit>();
      if (!weatherCubit.state.showNotificationWindow) {
        _geoDialogOpen = false;
        return;
      }

      await showGeoPermissionDialog(shellContext, weatherCubit);
      _geoDialogOpen = false;
    });
  }

  void _onCitySelected(
    BuildContext shellContext,
    CityWeatherCardEntity card,
  ) {
    shellContext.read<WeatherScreenCubit>().getWeatherByName(card.cityName);
    setState(() => _selectedTab = 0);
  }
}

class _ShellPlaceholder extends StatelessWidget {
  const _ShellPlaceholder({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
