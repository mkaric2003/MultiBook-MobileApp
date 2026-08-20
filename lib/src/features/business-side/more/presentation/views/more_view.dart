import 'package:aquabook/app.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/features/business-side/more/bloc/more_cubit.dart';
import 'package:aquabook/src/features/business-side/more/bloc/more_state.dart';
import 'package:aquabook/src/features/business-side/more/domain/models/more_menu_item.dart';
import 'package:aquabook/src/features/business-side/more/presentation/widgets/more_header.dart';
import 'package:aquabook/src/features/business-side/more/presentation/widgets/more_menu_section.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key, required this.onLogout});

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MoreCubit>()..load(),
      child: BlocBuilder<MoreCubit, MoreState>(
        builder: (context, state) => SafeArea(
          bottom: false,
          child: Column(
            children: [
              MoreHeader(
                businesses: state.businesses,
                selectedBusiness: state.selectedBusiness,
                onBusinessSelected: context.read<MoreCubit>().selectBusiness,
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                  children: [
                    MoreMenuSection(
                      title: 'Business management',
                      items: [
                        MoreMenuItem(
                          label: 'Business Profile',
                          icon: Icons.apartment_rounded,
                        ),
                        MoreMenuItem(
                          label: 'Manage Stays & Services',
                          icon: Icons.bed_rounded,
                        ),
                        MoreMenuItem(
                          label: 'Availability & Calendar',
                          icon: Icons.calendar_month_rounded,
                          onTap: () =>
                              context.push(AppRoutes.AVAILABILITY_CALENDAR),
                        ),
                        MoreMenuItem(
                          label: 'Promotions & Discounts',
                          icon: Icons.percent_rounded,
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    MoreMenuSection(
                      title: 'Financials',
                      items: [
                        MoreMenuItem(
                          label: 'Payout Methods',
                          icon: Icons.credit_card_rounded,
                        ),
                        MoreMenuItem(
                          label: 'Transaction History',
                          icon: Icons.show_chart_rounded,
                        ),
                        MoreMenuItem(
                          label: 'Invoices & Tax Information',
                          icon: Icons.description_outlined,
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    MoreMenuSection(
                      title: 'Notifications & Communication',
                      items: [
                        MoreMenuItem(
                          label: 'Notifications',
                          icon: Icons.notifications_rounded,
                          onTap: () => context.push(AppRoutes.NOTIFICATIONS),
                        ),
                        MoreMenuItem(
                          label: 'Messages',
                          icon: Icons.chat_bubble_rounded,
                          badgeCount: state.unreadMessagesCount > 0
                              ? state.unreadMessagesCount
                              : null,
                          onTap: () => context.push(AppRoutes.CHAT_LIST),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    MoreMenuSection(
                      title: 'Settings',
                      items: [
                        MoreMenuItem(
                          label: 'Account Settings',
                          icon: Icons.person_rounded,
                          onTap: () => context.push(AppRoutes.ACCOUNT_SETTINGS),
                        ),
                        MoreMenuItem(
                          label: 'Language & Localization',
                          icon: Icons.language_rounded,
                        ),
                        MoreMenuItem(
                          label: 'Help & Support',
                          icon: Icons.help_rounded,
                        ),
                        MoreMenuItem(
                          label: 'Terms of Service',
                          icon: Icons.article_outlined,
                        ),
                        MoreMenuItem(
                          label: 'Privacy Policy',
                          icon: Icons.shield_outlined,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      buttonName: 'Logout',
                      color: Colors.transparent,
                      textColor: const Color(0xFFFF4B4B),
                      borderColor: const Color(0xFFFF4B4B),
                      leadingIcon: const Icon(Icons.logout_rounded),
                      height: 48,
                      fontSize: 15,
                      onPressed: onLogout,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
