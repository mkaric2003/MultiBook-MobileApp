import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/other_stays_grid.dart';
import 'package:multibook/src/features/customer-side/explore/cubit/explore_stay_results_cubit.dart';
import 'package:multibook/src/features/customer-side/explore/cubit/explore_stay_results_state.dart';
import 'package:multibook/src/features/customer-side/explore/domain/models/explore_stay_results_arguments.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreStayResultsView extends StatelessWidget {
  const ExploreStayResultsView({required this.arguments, super.key});

  final ExploreStayResultsArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ExploreStayResultsCubit>()..load(arguments),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(title: arguments.categoryTitle),
              Expanded(
                child:
                    BlocBuilder<
                      ExploreStayResultsCubit,
                      ExploreStayResultsState
                    >(
                      builder: (context, state) =>
                          NotificationListener<ScrollNotification>(
                            onNotification: (notification) {
                              if (notification.metrics.extentAfter < 240) {
                                context
                                    .read<ExploreStayResultsCubit>()
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
                                  OtherStaysGrid(
                                    stays: state.stays,
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
