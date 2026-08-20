import 'package:weather_app/core/add_images/images.dart';

abstract final class CityImageHelper {
  static const _defaultNetworkImage =
      'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?auto=format&fit=crop&w=900&q=80';

  static const _networkImages = {
    'moscow': 'https://images.unsplash.com/photo-1513326738677-a960b278576b?auto=format&fit=crop&w=900&q=80',
    'saint petersburg':
        'https://images.unsplash.com/photo-1556610960-097977468775?auto=format&fit=crop&w=900&q=80',
    'sochi':
        'https://images.unsplash.com/photo-1596484552834-086c38e91968?auto=format&fit=crop&w=900&q=80',
    'london':
        'https://images.unsplash.com/photo-1513635269977-59663e0ac1ad?auto=format&fit=crop&w=900&q=80',
    'paris':
        'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?auto=format&fit=crop&w=900&q=80',
    'dubai':
        'https://images.unsplash.com/photo-1512453979798-5ea266f8880c?auto=format&fit=crop&w=900&q=80',
    'tokyo':
        'https://images.unsplash.com/photo-1540959733332-eab4deab809a?auto=format&fit=crop&w=900&q=80',
    'new york':
        'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?auto=format&fit=crop&w=900&q=80',
  };

  static const _assetImages = {
    'new york': AppImages.newYork,
  };

  static String? assetPathFor(String cityName) {
    return _assetImages[_normalize(cityName)];
  }

  static String networkUrlFor(String cityName) {
    return _networkImages[_normalize(cityName)] ?? _defaultNetworkImage;
  }

  static String _normalize(String cityName) => cityName.trim().toLowerCase();
}
