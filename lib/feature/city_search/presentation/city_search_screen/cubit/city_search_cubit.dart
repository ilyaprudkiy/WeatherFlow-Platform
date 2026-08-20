import 'package:bloc/bloc.dart';
import 'package:weather_app/feature/city_search/domain/entity/city_weather_card_entity.dart';
import 'package:weather_app/feature/city_search/domain/use_cases/city_search_use_case.dart';
import 'city_search_state.dart';

class CitySearchCubit extends Cubit<CitySearchState> {
  CitySearchCubit(this._useCase) : super(const CitySearchState());

  final CitySearchUseCase _useCase;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final result = await _useCase.loadSearchSnapshot();
    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          error: failure.message,
        ),
      ),
      (snapshot) => emit(
        state.copyWith(
          isLoading: false,
          locationCard: snapshot.locationCard,
          recentCards: snapshot.recentCards,
          popularCards: snapshot.popularCards,
        ),
      ),
    );
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  Future<void> clearRecent() async {
    final result = await _useCase.clearRecentCities();
    result.fold(
      (failure) => emit(state.copyWith(error: failure.message)),
      (_) => emit(state.copyWith(recentCards: const [])),
    );
  }

  Future<CityWeatherCardEntity?> selectCity(CityWeatherCardEntity card) async {
    await _useCase.rememberRecentCity(card.cityName);
    await load();
    return card;
  }
}
