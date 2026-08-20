import 'package:aquabook/src/features/customer-side/dashboard/domain/enums/service_sort_option.dart';

class ServiceFilters {
  const ServiceFilters({
    this.date,
    this.timeMinutes,
    this.serviceName,
    this.city,
    this.minPrice = 0,
    this.maxPrice = 500,
    this.sortOption = ServiceSortOption.recommended,
  });

  final DateTime? date;
  final int? timeMinutes;
  final String? serviceName;
  final String? city;
  final double minPrice;
  final double maxPrice;
  final ServiceSortOption sortOption;

  bool get hasActiveFilters =>
      date != null ||
      timeMinutes != null ||
      serviceName != null ||
      city != null ||
      minPrice > 0 ||
      maxPrice < 500 ||
      sortOption != ServiceSortOption.recommended;

  int get appliedFiltersCount => [
    if (date != null) true,
    if (timeMinutes != null) true,
    if (serviceName != null) true,
    if (city != null) true,
    if (minPrice > 0 || maxPrice < 500) true,
    if (sortOption != ServiceSortOption.recommended) true,
  ].length;

  ServiceFilters copyWith({
    DateTime? date,
    int? timeMinutes,
    String? serviceName,
    String? city,
    bool clearDate = false,
    bool clearTime = false,
    bool clearServiceName = false,
    bool clearCity = false,
    double? minPrice,
    double? maxPrice,
    ServiceSortOption? sortOption,
  }) {
    return ServiceFilters(
      date: clearDate ? null : date ?? this.date,
      timeMinutes: clearTime ? null : timeMinutes ?? this.timeMinutes,
      serviceName: clearServiceName ? null : serviceName ?? this.serviceName,
      city: clearCity ? null : city ?? this.city,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      sortOption: sortOption ?? this.sortOption,
    );
  }
}
