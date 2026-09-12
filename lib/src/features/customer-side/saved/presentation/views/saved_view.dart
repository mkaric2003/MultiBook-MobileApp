import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/customer-side/saved/cubit/saved_cubit.dart';
import 'package:multibook/src/features/customer-side/saved/cubit/saved_state.dart';
import 'package:multibook/src/features/customer-side/saved/presentation/widgets/saved_business_card.dart';
import 'package:multibook/src/features/customer-side/saved/presentation/widgets/saved_businesses_skeleton.dart';
import 'package:toastification/toastification.dart';

class SavedView extends StatelessWidget {
  const SavedView({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<SavedCubit>()..load(),
    child: BlocBuilder<SavedCubit, SavedState>(
      builder: (context, state) => SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              height: 86,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: context.appPalette.surfaceHighlight,
                  ),
                ),
              ),
              child: Text(
                context.l10n.saved,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Expanded(
              child: state.isLoading && state.businesses.isEmpty
                  ? const SavedBusinessesSkeleton()
                  : state.hasError && state.businesses.isEmpty
                  ? Center(
                      child: IconButton(
                        onPressed: () => context.read<SavedCubit>().load(),
                        icon: const Icon(Icons.refresh),
                      ),
                    )
                  : state.businesses.isEmpty
                  ? Center(
                      child: Text(
                        context.l10n.noSavedStaysYet,
                        style: TextStyle(color: context.appPalette.muted),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 90),
                      itemCount: state.businesses.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 18),
                      itemBuilder: (context, index) {
                        final stay = state.businesses[index];
                        return AnimatedSize(
                          key: ValueKey(stay.id),
                          duration: const Duration(milliseconds: 280),
                          child: state.removingId == stay.id
                              ? const SizedBox.shrink()
                              : Dismissible(
                                  key: ValueKey(stay.id),
                                  direction: DismissDirection.endToStart,
                                  confirmDismiss: (_) async {
                                    final removed = await context
                                        .read<SavedCubit>()
                                        .remove(stay);
                                    if (context.mounted && removed) {
                                      _showRemoved(context);
                                    }
                                    return false;
                                  },
                                  background: const ColoredBox(
                                    color: Colors.red,
                                  ),
                                  child: SavedBusinessCard(
                                    business: stay,
                                    onRemove: () async {
                                      final removed = await context
                                          .read<SavedCubit>()
                                          .remove(stay);
                                      if (context.mounted && removed) {
                                        _showRemoved(context);
                                      }
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
  void _showRemoved(BuildContext context) {
    toastification.show(
      context: context,
      autoCloseDuration: const Duration(seconds: 2),
      type: ToastificationType.warning,
      alignment: Alignment.bottomCenter,
      title: Text(context.l10n.removedFromSaved),
    );
  }
}
