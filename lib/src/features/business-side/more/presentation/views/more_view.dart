import 'package:aquabook/app.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/features/business-side/more/bloc/more_cubit.dart';
import 'package:aquabook/src/features/business-side/more/bloc/more_state.dart';
import 'package:aquabook/src/features/business-side/more/domain/models/more_menu_item.dart';
import 'package:aquabook/src/features/business-side/more/presentation/widgets/more_header.dart';
import 'package:aquabook/src/features/business-side/more/presentation/widgets/more_menu_section.dart';
import 'package:aquabook/src/features/shared/localization/presentation/widgets/language_picker_sheet.dart';
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
                      title: context.l10n.businessManagement,
                      items: [
                        MoreMenuItem(
                          label: context.l10n.businessProfile,
                          icon: Icons.apartment_rounded,
                        ),
                        MoreMenuItem(
                          label: context.l10n.manageStaysAndServices,
                          icon: Icons.bed_rounded,
                        ),
                        MoreMenuItem(
                          label: context.l10n.availabilityAndCalendar,
                          icon: Icons.calendar_month_rounded,
                          onTap: () =>
                              context.push(AppRoutes.AVAILABILITY_CALENDAR),
                        ),
                        MoreMenuItem(
                          label: context.l10n.promotionsAndDiscounts,
                          icon: Icons.percent_rounded,
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    MoreMenuSection(
                      title: context.l10n.financials,
                      items: [
                        MoreMenuItem(
                          label: context.l10n.payoutMethods,
                          icon: Icons.credit_card_rounded,
                        ),
                        MoreMenuItem(
                          label: context.l10n.transactionHistory,
                          icon: Icons.show_chart_rounded,
                        ),
                        MoreMenuItem(
                          label: context.l10n.invoicesAndTaxInformation,
                          icon: Icons.description_outlined,
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    MoreMenuSection(
                      title: context.l10n.notificationsAndCommunication,
                      items: [
                        MoreMenuItem(
                          label: context.l10n.notifications,
                          icon: Icons.notifications_rounded,
                          onTap: () => context.push(AppRoutes.NOTIFICATIONS),
                        ),
                        MoreMenuItem(
                          label: context.l10n.messages,
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
                      title: context.l10n.settings,
                      items: [
                        MoreMenuItem(
                          label: context.l10n.accountSettings,
                          icon: Icons.person_rounded,
                          onTap: () => context.push(AppRoutes.ACCOUNT_SETTINGS),
                        ),
                        MoreMenuItem(
                          label: context.l10n.languageAndLocalization,
                          icon: Icons.language_rounded,
                          onTap: () => LanguagePickerSheet.show(context),
                        ),
                        MoreMenuItem(
                          label: context.l10n.helpAndSupport,
                          icon: Icons.help_rounded,
                        ),
                        MoreMenuItem(
                          label: context.l10n.termsOfService,
                          icon: Icons.article_outlined,
                        ),
                        MoreMenuItem(
                          label: context.l10n.privacyPolicy,
                          icon: Icons.shield_outlined,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      buttonName: context.l10n.logOut,
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
