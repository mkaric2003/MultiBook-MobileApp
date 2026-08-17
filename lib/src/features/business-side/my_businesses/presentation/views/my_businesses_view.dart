import 'package:aquabook/app.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/business-side/my_businesses/bloc/my_businesses_cubit.dart';
import 'package:aquabook/src/features/business-side/my_businesses/bloc/my_businesses_state.dart';
import 'package:aquabook/src/features/business-side/my_businesses/presentation/widgets/my_business_list_tile.dart';
import 'package:aquabook/src/features/business-side/my_businesses/presentation/widgets/my_businesses_header.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyBusinessesView extends StatelessWidget {
  const MyBusinessesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MyBusinessesCubit>()..load(),
      child: BlocConsumer<MyBusinessesCubit, MyBusinessesState>(
        listenWhen: (previous, current) =>
            previous.isSelecting && !current.isSelecting,
        listener: (context, state) => context.go(AppRoutes.HOME),
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  const MyBusinessesHeader(),
                  Expanded(
                    child: state.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView(
                            padding: const EdgeInsets.fromLTRB(25, 32, 25, 24),
                            children: [
                              const Text(
                                'Select a business to manage or add a new one.',
                                style: TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 40),
                              if (state.businesses.isEmpty)
                                const Center(
                                  child: Text(
                                    'No businesses yet.',
                                    style: TextStyle(color: AppColors.muted),
                                  ),
                                )
                              else
                                ...state.businesses.map(
                                  (business) => Dismissible(
                                    key: ValueKey(business.id),
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      margin: const EdgeInsets.only(bottom: 22),
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.only(right: 28),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFDC2626),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Icon(
                                        Icons.delete_outline,
                                        size: 30,
                                      ),
                                    ),
                                    confirmDismiss: (_) async {
                                      final didDelete = await context
                                          .read<MyBusinessesCubit>()
                                          .deleteBusiness(business);
                                      if (!didDelete && context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'We could not delete this business.',
                                            ),
                                          ),
                                        );
                                      }
                                      return didDelete;
                                    },
                                    onDismissed: (_) => context
                                        .read<MyBusinessesCubit>()
                                        .removeBusiness(business.id),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 22,
                                      ),
                                      child: MyBusinessListTile(
                                        business: business,
                                        onTap: () => context
                                            .read<MyBusinessesCubit>()
                                            .selectBusiness(business.id),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 12, 25, 5),
                child: CustomButton(
                  buttonName: 'Add New Business',
                  leadingIcon: const Icon(Icons.add),
                  onPressed: () => context.push(AppRoutes.ADD_BUSINESS),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
