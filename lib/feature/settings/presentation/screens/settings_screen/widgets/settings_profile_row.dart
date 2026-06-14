import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/app_text_styles.dart';

class SettingsProfileRow extends StatelessWidget {
  const SettingsProfileRow({super.key, required this.name});

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
            backgroundColor: AppColors.avatarBackground,
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
                Text(name, style: AppTextStyles.settingsProfileName),
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
