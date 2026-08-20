import 'package:aquabook/src/data/models/business_model.dart';

class MoreState {
  const MoreState({
    this.isLoading = true,
    this.businesses = const [],
    this.selectedBusiness,
    this.unreadMessagesCount = 0,
  });

  final bool isLoading;
  final List<BusinessModel> businesses;
  final BusinessModel? selectedBusiness;
  final int unreadMessagesCount;

  MoreState copyWith({
    bool? isLoading,
    List<BusinessModel>? businesses,
    BusinessModel? selectedBusiness,
    int? unreadMessagesCount,
  }) => MoreState(
    isLoading: isLoading ?? this.isLoading,
    businesses: businesses ?? this.businesses,
    selectedBusiness: selectedBusiness ?? this.selectedBusiness,
    unreadMessagesCount: unreadMessagesCount ?? this.unreadMessagesCount,
  );
}
