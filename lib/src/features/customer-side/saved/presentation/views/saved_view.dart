import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/features/customer-side/saved/cubit/saved_cubit.dart';
import 'package:aquabook/src/features/customer-side/saved/cubit/saved_state.dart';
import 'package:aquabook/src/features/customer-side/saved/presentation/widgets/saved_business_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class SavedView extends StatelessWidget {
  const SavedView({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<SavedCubit>()..load(),
    child: BlocBuilder<SavedCubit, SavedState>(
      builder: (context, state) => SafeArea(
        child: Column(
          children: [
            Container(
              height: 86,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.surfaceHighlight),
                ),
              ),
              child: const Text(
                'Saved',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
            ),
            Expanded(
              child: state.stays.isEmpty
                  ? const Center(
                      child: Text(
                        'No saved stays yet.',
                        style: TextStyle(color: AppColors.muted),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(20),
                      itemCount: state.stays.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 18),
                      itemBuilder: (context, index) {
                        final stay = state.stays[index];
                        return AnimatedSize(
                          key: ValueKey(stay.id),
                          duration: const Duration(milliseconds: 280),
                          child: state.removingId == stay.id
                              ? const SizedBox.shrink()
                              : Dismissible(
                                  key: ValueKey(stay.id),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (_) {
                                    context.read<SavedCubit>().remove(stay);
                                    toastification.show(
                                      context: context,
                                      autoCloseDuration: const Duration(
                                        seconds: 2,
                                      ),
                                      type: ToastificationType.warning,
                                      alignment: Alignment.bottomCenter,
                                      title: Text(context.l10n.removedFromSaved),
                                    );
                                  },
                                  background: const ColoredBox(
                                    color: Colors.red,
                                  ),
                                  child: SavedBusinessCard(
                                    stay: stay,
                                    onRemove: () {
                                      context.read<SavedCubit>().remove(stay);
                                      toastification.show(
                                        context: context,
                                        autoCloseDuration: const Duration(
                                          seconds: 2,
                                        ),
                                        type: ToastificationType.warning,
                                        alignment: Alignment.bottomCenter,
                                        title: Text(context.l10n.removedFromSaved),
                                      );
                                    },
                                  ),
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
