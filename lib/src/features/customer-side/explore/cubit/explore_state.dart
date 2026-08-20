class ExploreState {
  const ExploreState({
    this.isLoading = true,
    this.selectedCity,
    this.cities = const [],
  });

  final bool isLoading;
  final String? selectedCity;
  final List<String> cities;

  ExploreState copyWith({
    bool? isLoading,
    String? selectedCity,
    bool clearSelectedCity = false,
    List<String>? cities,
  }) => ExploreState(
    isLoading: isLoading ?? this.isLoading,
    selectedCity: clearSelectedCity ? null : selectedCity ?? this.selectedCity,
    cities: cities ?? this.cities,
  );
}
