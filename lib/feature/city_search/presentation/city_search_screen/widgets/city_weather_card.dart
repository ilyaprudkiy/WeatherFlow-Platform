import 'package:flutter/material.dart';
import 'package:weather_app/core/add_images/images.dart';
import 'package:weather_app/core/theme/app_radius.dart';
import 'package:weather_app/core/theme/app_shadows.dart';
import 'package:weather_app/core/theme/app_text_styles.dart';
import 'package:weather_app/feature/city_search/domain/entity/city_weather_card_entity.dart';
import 'package:weather_app/feature/city_search/presentation/city_search_screen/utils/city_image_helper.dart';
import 'package:weather_app/feature/weather/presentation/weather_screen/utils/weather_icon_helper.dart';

class CityWeatherCard extends StatelessWidget {
  const CityWeatherCard({
    super.key,
    required this.card,
    required this.onTap,
  });

  final CityWeatherCardEntity card;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            child: Ink(
              height: 96,
              decoration: BoxDecoration(
                boxShadow: AppShadows.card(alpha: 0.08),
              ),
              child: Stack(
              fit: StackFit.expand,
              children: [
                _CityBackgroundImage(cityName: card.cityName),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.black.withValues(alpha: 0.55),
                        Colors.black.withValues(alpha: 0.35),
                        Colors.black.withValues(alpha: 0.2),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      if (_leadingIcon(card.kind) != null) ...[
                        _LeadingIcon(icon: _leadingIcon(card.kind)!),
                        const SizedBox(width: 14),
                      ],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              card.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.settingsProfileName.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              card.subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.settingsRow.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildWeatherIcon(
                                iconCode: card.iconCode,
                                size: 28,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                card.temperatureLabel,
                                style: AppTextStyles.sectionTitle.copyWith(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            card.weatherDescription,
                            style: AppTextStyles.settingsRow.copyWith(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }

  IconData? _leadingIcon(CityCardKind kind) {
    return switch (kind) {
      CityCardKind.currentLocation => Icons.near_me_rounded,
      CityCardKind.recent => Icons.history_rounded,
      CityCardKind.popular => null,
    };
  }
}

class _CityBackgroundImage extends StatelessWidget {
  const _CityBackgroundImage({required this.cityName});

  final String cityName;

  @override
  Widget build(BuildContext context) {
    final assetPath = CityImageHelper.assetPathFor(cityName);

    if (assetPath != null) {
      return Image.asset(
        assetPath,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _NetworkCityImage(cityName: cityName),
      );
    }

    return _NetworkCityImage(cityName: cityName);
  }
}

class _NetworkCityImage extends StatelessWidget {
  const _NetworkCityImage({required this.cityName});

  final String cityName;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      CityImageHelper.networkUrlFor(cityName),
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(color: Colors.grey.shade300);
      },
      errorBuilder: (_, __, ___) => Image.asset(
        AppImages.backgroundWeather,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _LeadingIcon extends StatelessWidget {
  const _LeadingIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white24),
      ),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }
}
