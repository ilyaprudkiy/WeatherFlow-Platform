import 'package:weather_app/feature/city_search/domain/entity/city_weather_card_entity.dart';

class CitySearchState {
  final bool isLoading;
  final String searchQuery;
  final CityWeatherCardEntity? locationCard;
  final List<CityWeatherCardEntity> recentCards;
  final List<CityWeatherCardEntity> popularCards;
  final String? error;

  const CitySearchState({
    this.isLoading = false,
    this.searchQuery = '',
    this.locationCard,
    this.recentCards = const [],
    this.popularCards = const [],
    this.error,
  });

  bool get isSearching => searchQuery.trim().isNotEmpty;

  CityWeatherCardEntity? get visibleLocationCard {
    final card = locationCard;
    if (card == null) return null;
    return card.matchesQuery(searchQuery) ? card : null;
  }

  List<CityWeatherCardEntity> get visibleRecentCards =>
      recentCards.where((card) => card.matchesQuery(searchQuery)).toList();

  List<CityWeatherCardEntity> get visiblePopularCards =>
      popularCards.where((card) => card.matchesQuery(searchQuery)).toList();

  bool get showLocationSection => visibleLocationCard != null;

  bool get showRecentSection => visibleRecentCards.isNotEmpty;

  bool get showPopularSection => visiblePopularCards.isNotEmpty;

  bool get showEmptyState =>
      !isLoading &&
      error == null &&
      !showLocationSection &&
      !showRecentSection &&
      !showPopularSection;

  CitySearchState copyWith({
    bool? isLoading,
    String? searchQuery,
    CityWeatherCardEntity? locationCard,
    List<CityWeatherCardEntity>? recentCards,
    List<CityWeatherCardEntity>? popularCards,
    String? error,
    bool clearError = false,
    bool clearLocation = false,
  }) {
    return CitySearchState(
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
      locationCard:
          clearLocation ? null : (locationCard ?? this.locationCard),
      recentCards: recentCards ?? this.recentCards,
      popularCards: popularCards ?? this.popularCards,
      error: clearError ? null : (error ?? this.error),
    );
  }
}
