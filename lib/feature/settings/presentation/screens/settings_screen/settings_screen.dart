import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase, User;
import 'package:weather_app/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:weather_app/navigation/navigation.dart';

const _background = Color(0xFFF3F4F6);
const _cardRadius = 18.0;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is NotAuthorizedState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            MainNavigationRouteNames.welcomeScreen,
            (_) => false,
          );
        }
      },
      child: const Scaffold(
        backgroundColor: _background,
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
  bool _generalExpanded = true;
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
          _SettingsHeader(onBack: () => Navigator.of(context).pop()),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                _SettingsCard(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => setState(
                          () => _generalExpanded = !_generalExpanded,
                        ),
                        borderRadius: BorderRadius.circular(_cardRadius),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(18, 18, 14, 18),
                          child: Row(
                            children: [
                              const Text(
                                'Weather Preferences',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                _generalExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (_generalExpanded) ...[
                        const _CardDivider(),
                        _ProfileRow(name: displayName),
                        const _CardDivider(),
                        _SettingsLabelRow(
                          label: 'Account',
                          onTap: () => _showInfo(
                            context,
                            'Manage your email and password.',
                          ),
                        ),
                        const _CardDivider(),
                        _SettingsLabelRow(
                          label: 'Default Location',
                          onTap: () => _showInfo(
                            context,
                            'Choose how the app picks your city on launch.',
                          ),
                        ),
                        const _CardDivider(),
                        _SettingsSwitchRow(
                          label: 'Weather Alerts',
                          value: _weatherAlerts,
                          onChanged: (value) =>
                              setState(() => _weatherAlerts = value),
                        ),
                        const _CardDivider(),
                        _SettingsSwitchRow(
                          label: 'Use Celsius (°C)',
                          value: _useCelsius,
                          onChanged: (value) =>
                              setState(() => _useCelsius = value),
                        ),
                        const _CardDivider(),
                        _SettingsSwitchRow(
                          label: 'Dark Mode',
                          value: _darkMode,
                          onChanged: (value) =>
                              setState(() => _darkMode = value),
                        ),
                        const SizedBox(height: 6),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _SettingsActionCard(
                  icon: Icons.bookmark_outline_rounded,
                  label: 'Saved Cities',
                  onTap: () => _showInfo(
                    context,
                    'Quick access to cities you saved in the app.',
                  ),
                ),
                const SizedBox(height: 12),
                _SettingsActionCard(
                  icon: Icons.location_on_outlined,
                  label: 'Location & Permissions',
                  onTap: () => _showInfo(
                    context,
                    'Control GPS access and location-based forecasts.',
                  ),
                ),
                const SizedBox(height: 12),
                _SettingsActionCard(
                  icon: Icons.wb_sunny_outlined,
                  label: 'Forecast Details',
                  onTap: () => _showInfo(
                    context,
                    'Choose what to show in hourly and 7-day forecasts.',
                  ),
                ),
                const SizedBox(height: 12),
                _SettingsActionCard(
                  icon: Icons.help_outline_rounded,
                  label: 'Help & Support',
                  onTap: () => _showInfo(
                    context,
                    'FAQ, report a problem, or send feedback.',
                  ),
                ),
                const SizedBox(height: 12),
                _SettingsActionCard(
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class _SettingsHeader extends StatelessWidget {
  const _SettingsHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 16, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            color: Colors.black87,
          ),
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final avatarUrl = Supabase.instance.client.auth.currentUser
        ?.userMetadata?['avatar_url'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: const Color(0xFFE8E8ED),
            backgroundImage: avatarUrl is String && avatarUrl.isNotEmpty
                ? NetworkImage(avatarUrl)
                : null,
            child: avatarUrl is! String || avatarUrl.isEmpty
                ? const Icon(Icons.person, color: Colors.black45, size: 28)
                : null,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Edit profile',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsLabelRow extends StatelessWidget {
  const _SettingsLabelRow({
    required this.label,
    this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              if (onTap != null)
                Icon(Icons.chevron_right, color: Colors.grey.shade500),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsSwitchRow extends StatelessWidget {
  const _SettingsSwitchRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 12, 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeTrackColor: Colors.black87,
            inactiveTrackColor: const Color(0xFFE5E7EB),
            inactiveThumbColor: const Color(0xFF374151),
          ),
        ],
      ),
    );
  }
}

class _SettingsActionCard extends StatelessWidget {
  const _SettingsActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _SettingsCard(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(_cardRadius),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: Row(
              children: [
                Icon(icon, size: 22, color: Colors.black87),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade500,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardDivider extends StatelessWidget {
  const _CardDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey.shade200,
    );
  }
}
