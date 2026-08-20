import 'package:aquabook/app.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/shared/recently_viewed/cubit/recently_viewed_services_cubit.dart';
import 'package:aquabook/src/features/shared/recently_viewed/cubit/recently_viewed_services_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ExploreRecentServices extends StatelessWidget {
  const ExploreRecentServices({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<RecentlyViewedServicesCubit>()..load(),
    child:
        BlocBuilder<RecentlyViewedServicesCubit, RecentlyViewedServicesState>(
          builder: (context, state) {
            if (state.isLoading || state.services.isEmpty) {
              return const SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 22),
                const Text(
                  'Recently viewed',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 110,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.services.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 13),
                    itemBuilder: (context, index) {
                      final service = state.services[index];
                      return InkWell(
                        onTap: () => context.push(
                          AppRoutes.SERVICE_DETAIL,
                          extra: service,
                        ),
                        borderRadius: BorderRadius.circular(32),
                        child: SizedBox(
                          width: 70,
                          child: Column(
                            children: [
                              ClipOval(
                                child: Image.network(
                                  service.imageUrl,
                                  height: 58,
                                  width: 58,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) => Container(
                                    height: 58,
                                    width: 58,
                                    color: AppColors.surface,
                                    child: const Icon(
                                      Icons.design_services_rounded,
                                      color: AppColors.muted,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                service.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
  );
}
