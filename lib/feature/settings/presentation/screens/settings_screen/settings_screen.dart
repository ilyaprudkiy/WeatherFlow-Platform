import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase, User;
import 'package:weather_app/core/navigation/auth_navigation.dart';
import 'package:weather_app/core/widgets/app_snackbar.dart';
import 'package:weather_app/feature/auth/presentation/cubit/auth_cubit.dart';
import 'widgets/settings_action_card.dart';
import 'widgets/settings_constants.dart';
import 'widgets/settings_header.dart';
import 'widgets/settings_weather_preferences_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is NotAuthorizedState) {
          navigateToWelcome(context);
        }
      },
      child: const Scaffold(
        backgroundColor: settingsBackground,
        body: _SettingsBody(),
      ),
    );
  }
}

class _SettingsBody extends StatefulWidget {
  const _SettingsBody();

  @override
  State<_SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<_SettingsBody> {
  bool _weatherPrefsExpanded = true;
  bool _weatherAlerts = false;
  bool _darkMode = false;
  bool _useCelsius = true;

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final email = user?.email ?? 'guest@weather.app';
    final displayName = _resolveDisplayName(user, email);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsHeader(onBack: () => Navigator.of(context).pop()),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                SettingsWeatherPreferencesCard(
                  expanded: _weatherPrefsExpanded,
                  displayName: displayName,
                  weatherAlerts: _weatherAlerts,
                  useCelsius: _useCelsius,
                  darkMode: _darkMode,
                  onToggleExpanded: () => setState(
                    () => _weatherPrefsExpanded = !_weatherPrefsExpanded,
                  ),
                  onWeatherAlertsChanged: (value) =>
                      setState(() => _weatherAlerts = value),
                  onUseCelsiusChanged: (value) =>
                      setState(() => _useCelsius = value),
                  onDarkModeChanged: (value) =>
                      setState(() => _darkMode = value),
                  onAccountTap: () => _showInfo(
                    context,
                    'Manage your email and password.',
                  ),
                  onDefaultLocationTap: () => _showInfo(
                    context,
                    'Choose how the app picks your city on launch.',
                  ),
                ),
                const SizedBox(height: 12),
                SettingsActionCard(
                  icon: Icons.bookmark_outline_rounded,
                  label: 'Saved Cities',
                  onTap: () => _showInfo(
                    context,
                    'Quick access to cities you saved in the app.',
                  ),
                ),
                const SizedBox(height: 12),
                SettingsActionCard(
                  icon: Icons.location_on_outlined,
                  label: 'Location & Permissions',
                  onTap: () => _showInfo(
                    context,
                    'Control GPS access and location-based forecasts.',
                  ),
                ),
                const SizedBox(height: 12),
                SettingsActionCard(
                  icon: Icons.wb_sunny_outlined,
                  label: 'Forecast Details',
                  onTap: () => _showInfo(
                    context,
                    'Choose what to show in hourly and 7-day forecasts.',
                  ),
                ),
                const SizedBox(height: 12),
                SettingsActionCard(
                  icon: Icons.help_outline_rounded,
                  label: 'Help & Support',
                  onTap: () => _showInfo(
                    context,
                    'FAQ, report a problem, or send feedback.',
                  ),
                ),
                const SizedBox(height: 12),
                SettingsActionCard(
                  icon: Icons.logout,
                  label: 'Log out',
                  onTap: () => context.read<AuthCubit>().logout(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _resolveDisplayName(User? user, String email) {
    final metadataName = user?.userMetadata?['full_name'];
    if (metadataName is String && metadataName.trim().isNotEmpty) {
      return metadataName.trim();
    }

    final localPart = email.split('@').first;
    if (localPart.isEmpty) return 'User';

    return localPart[0].toUpperCase() + localPart.substring(1);
  }

  void _showInfo(BuildContext context, String message) {
    context.showAppSnackBar(message);
  }
}
