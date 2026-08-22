import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/features/customer-side/dashboard/presentation/widgets/other_services_grid.dart';
import 'package:aquabook/src/features/customer-side/explore/cubit/explore_service_results_cubit.dart';
import 'package:aquabook/src/features/customer-side/explore/cubit/explore_service_results_state.dart';
import 'package:aquabook/src/features/customer-side/explore/domain/models/explore_service_results_arguments.dart';
import 'package:aquabook/src/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreServiceResultsView extends StatelessWidget {
  const ExploreServiceResultsView({required this.arguments, super.key});

  final ExploreServiceResultsArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ExploreServiceResultsCubit>()..load(arguments),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(title: arguments.categoryTitle),
              Expanded(
                child:
                    BlocBuilder<
                      ExploreServiceResultsCubit,
                      ExploreServiceResultsState
                    >(
                      builder: (context, state) =>
                          NotificationListener<ScrollNotification>(
                            onNotification: (notification) {
                              if (notification.metrics.extentAfter < 240) {
                                context
                                    .read<ExploreServiceResultsCubit>()
                                    .loadMore();
                              }
                              return false;
                            },
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.fromLTRB(
                                20,
                                24,
                                20,
                                28,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    arguments.city == null
                                        ? arguments.categoryTitle
                                        : context.l10n.inCity(
                                            arguments.categoryTitle,
                                            arguments.city!,
                                          ),
                                    style: const TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  OtherServicesGrid(
                                    services: state.services,
                                    isLoading: state.isLoading,
                                    emptyMessage: arguments.city == null
                                        ? context.l10n.noCategoryAvailable(
                                            arguments.categoryTitle
                                                .toLowerCase(),
                                          )
                                        : context.l10n
                                              .noCategoryAvailableInCity(
                                                arguments.categoryTitle
                                                    .toLowerCase(),
                                                arguments.city!,
                                              ),
                                  ),
                                  if (state.isLoadingMore) ...[
                                    const SizedBox(height: 20),
                                    const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
