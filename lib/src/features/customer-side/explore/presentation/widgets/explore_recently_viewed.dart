import 'package:aquabook/app.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/shared/recently_viewed/cubit/recently_viewed_cubit.dart';
import 'package:aquabook/src/features/shared/recently_viewed/cubit/recently_viewed_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ExploreRecentlyViewed extends StatelessWidget {
  const ExploreRecentlyViewed({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<RecentlyViewedCubit>()..load(),
    child: BlocBuilder<RecentlyViewedCubit, RecentlyViewedState>(
      builder: (context, state) {
        if (state.isLoading || state.stays.isEmpty) {
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
              height: 122,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: state.stays.length,
                separatorBuilder: (_, _) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  final stay = state.stays[index];
                  return InkWell(
                    onTap: () =>
                        context.push(AppRoutes.STAY_DETAIL, extra: stay),
                    borderRadius: BorderRadius.circular(36),
                    child: SizedBox(
                      width: 79,
                      child: Column(
                        children: [
                          ClipOval(
                            child: Image.network(
                              stay.imageUrl,
                              height: 66,
                              width: 66,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => Container(
                                height: 66,
                                width: 66,
                                color: AppColors.surface,
                                child: const Icon(
                                  Icons.hotel_rounded,
                                  color: AppColors.muted,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            stay.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.muted,
                              fontSize: 11,
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
