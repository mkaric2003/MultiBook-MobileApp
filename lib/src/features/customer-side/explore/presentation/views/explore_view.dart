import 'package:aquabook/app.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:aquabook/src/features/customer-side/explore/cubit/explore_cubit.dart';
import 'package:aquabook/src/features/customer-side/explore/cubit/explore_state.dart';
import 'package:aquabook/src/features/customer-side/explore/domain/models/explore_category.dart';
import 'package:aquabook/src/features/customer-side/explore/domain/models/explore_collection.dart';
import 'package:aquabook/src/features/customer-side/explore/domain/models/explore_stay_results_arguments.dart';
import 'package:aquabook/src/features/customer-side/explore/domain/models/explore_service_category.dart';
import 'package:aquabook/src/features/customer-side/explore/domain/models/explore_service_collection.dart';
import 'package:aquabook/src/features/customer-side/explore/domain/models/explore_service_results_arguments.dart';
import 'package:aquabook/src/features/customer-side/explore/presentation/widgets/explore_app_bar.dart';
import 'package:aquabook/src/features/customer-side/explore/presentation/widgets/explore_services_content.dart';
import 'package:aquabook/src/features/customer-side/explore/presentation/widgets/explore_stays_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class ExploreView extends HookWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(CustomerHomeTab.stays);

    return BlocProvider(
      create: (_) => getIt<ExploreCubit>()..load(),
      child: BlocBuilder<ExploreCubit, ExploreState>(
        builder: (context, state) => SafeArea(
          child: Column(
            children: [
              ExploreAppBar(
                selectedCity: state.selectedCity,
                cities: state.cities,
                onCityChanged: context.read<ExploreCubit>().selectCity,
                trailing: selectedTab.value == CustomerHomeTab.services
                    ? IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search_rounded),
                      )
                    : null,
              ),
              Expanded(
                child: selectedTab.value == CustomerHomeTab.stays
                    ? ExploreStaysContent(
                        selectedTab: selectedTab.value,
                        onTabChanged: (tab) => selectedTab.value = tab,
                        onCategorySelected: (ExploreCategory category) {
                          final city = state.selectedCity;
                          context.push(
                            AppRoutes.EXPLORE_STAY_RESULTS,
                            extra: ExploreStayResultsArguments(
                              city: city,
                              categoryId: category.id,
                              categoryTitle: category.title,
                            ),
                          );
                        },
                        onCollectionSelected: (ExploreCollection collection) {
                          final city = state.selectedCity;
                          context.push(
                            AppRoutes.EXPLORE_STAY_RESULTS,
                            extra: ExploreStayResultsArguments(
                              city: city,
                              categoryId: '',
                              categoryTitle: collection.title,
                              collectionId: collection.id,
                            ),
                          );
                        },
                      )
                    : ExploreServicesContent(
                        selectedTab: selectedTab.value,
                        onTabChanged: (tab) => selectedTab.value = tab,
                        onCategorySelected: (ExploreServiceCategory category) {
                          context.push(
                            AppRoutes.EXPLORE_SERVICE_RESULTS,
                            extra: ExploreServiceResultsArguments(
                              city: state.selectedCity,
                              categoryId: category.id,
                              categoryTitle: category.title,
                            ),
                          );
                        },
                        onCollectionSelected:
                            (ExploreServiceCollection collection) {
                              context.push(
                                AppRoutes.EXPLORE_SERVICE_RESULTS,
                                extra: ExploreServiceResultsArguments(
                                  city: state.selectedCity,
                                  collectionId: collection.id,
                                  categoryTitle: collection.title,
                                ),
                              );
                            },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
