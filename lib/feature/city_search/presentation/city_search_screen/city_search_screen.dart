import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/theme/app_spacing.dart';
import 'package:weather_app/core/widgets/app_snackbar.dart';
import 'package:weather_app/feature/city_search/domain/entity/city_weather_card_entity.dart';
import 'package:weather_app/feature/city_search/presentation/city_search_screen/cubit/city_search_cubit.dart';
import 'package:weather_app/feature/city_search/presentation/city_search_screen/cubit/city_search_state.dart';
import 'package:weather_app/feature/city_search/presentation/city_search_screen/widgets/city_search_bar.dart';
import 'package:weather_app/feature/city_search/presentation/city_search_screen/widgets/city_search_section_header.dart';
import 'package:weather_app/feature/city_search/presentation/city_search_screen/widgets/city_weather_card.dart';

class CitySearchScreen extends StatefulWidget {
  const CitySearchScreen({
    super.key,
    required this.onCitySelected,
  });

  final ValueChanged<CityWeatherCardEntity> onCitySelected;

  @override
  State<CitySearchScreen> createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CitySearchBar(
              controller: _searchController,
              onChanged: context.read<CitySearchCubit>().updateSearchQuery,
            ),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: BlocConsumer<CitySearchCubit, CitySearchState>(
                  listenWhen: (prev, curr) => curr.error != prev.error,
                  listener: (context, state) {
                    if (state.error != null) {
                      context.showAppSnackBar(state.error!);
                    }
                  },
                  builder: (context, state) {
                    if (state.isLoading && state.recentCards.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.showEmptyState) {
                      return Center(
                        child: Text(
                          state.isSearching
                              ? 'No cities match your search'
                              : 'No cities to show',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      );
                    }

                    return ListView(
                      padding: const EdgeInsets.only(bottom: 24),
                      children: [
                        if (state.showLocationSection) ...[
                          const CitySearchSectionHeader(title: 'Your location'),
                          CityWeatherCard(
                            card: state.visibleLocationCard!,
                            onTap: () => _selectCard(
                              context,
                              state.visibleLocationCard!,
                            ),
                          ),
                        ],
                        if (state.showRecentSection) ...[
                          CitySearchSectionHeader(
                            title: 'Recent',
                            actionLabel: state.isSearching ? null : 'Clear',
                            onAction: state.isSearching
                                ? null
                                : () => context
                                    .read<CitySearchCubit>()
                                    .clearRecent(),
                          ),
                          ...state.visibleRecentCards.map(
                            (card) => CityWeatherCard(
                              card: card,
                              onTap: () => _selectCard(context, card),
                            ),
                          ),
                        ],
                        if (state.showPopularSection) ...[
                          const CitySearchSectionHeader(
                            title: 'Popular cities',
                          ),
                          ...state.visiblePopularCards.map(
                            (card) => CityWeatherCard(
                              card: card,
                              onTap: () => _selectCard(context, card),
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }

  Future<void> _selectCard(
    BuildContext context,
    CityWeatherCardEntity card,
  ) async {
    final selected =
        await context.read<CitySearchCubit>().selectCity(card);
    if (selected != null && context.mounted) {
      widget.onCitySelected(selected);
    }
  }
}
