import 'package:multibook/app.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/shared/recently_viewed/cubit/recently_viewed_cubit.dart';
import 'package:multibook/src/features/shared/recently_viewed/cubit/recently_viewed_state.dart';
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
            Text(
              context.l10n.recentlyViewed,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
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
                                color: context.appPalette.surface,
                                child: Icon(
                                  Icons.hotel_rounded,
                                  color: context.appPalette.muted,
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
                            style: TextStyle(
                              color: context.appPalette.muted,
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
