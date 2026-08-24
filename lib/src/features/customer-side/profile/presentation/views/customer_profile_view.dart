import 'package:aquabook/app.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/home/bloc/customer_home_bloc.dart';
import 'package:aquabook/src/features/customer-side/home/bloc/customer_home_event.dart';
import 'package:aquabook/src/features/customer-side/profile/cubit/customer_profile_cubit.dart';
import 'package:aquabook/src/features/customer-side/profile/cubit/customer_profile_state.dart';
import 'package:aquabook/src/features/customer-side/profile/presentation/widgets/customer_profile_menu_item.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomerProfileView extends StatelessWidget {
  const CustomerProfileView({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<CustomerProfileCubit>()..load(),
    child: BlocConsumer<CustomerProfileCubit, CustomerProfileState>(
      listener: (context, state) {
        if (state.isSignedOut) context.go(AppRoutes.SIGNIN);
      },
      builder: (context, state) {
        final user = state.user;
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        context.l10n.profile,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundColor: AppColors.surfaceHighlight,
                        backgroundImage: (user?.profileImageUrl ?? '').isEmpty
                            ? null
                            : NetworkImage(user!.profileImageUrl!),
                        child: (user?.profileImageUrl ?? '').isEmpty
                            ? const Icon(Icons.person, size: 44)
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user?.fullName ?? context.l10n.profile,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        user?.email ?? '',
                        style: const TextStyle(color: AppColors.muted),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  buttonName: context.l10n.editProfile,
                  onPressed: () =>
                      context.push(AppRoutes.CUSTOMER_EDIT_PROFILE),
                ),
                const SizedBox(height: 32),
                Text(
                  context.l10n.account,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 16),
                CustomerProfileMenuItem(
                  icon: Icons.calendar_month,
                  label: context.l10n.bookings,
                  onTap: () => context.read<CustomerHomeBloc>().add(
                    const CustomerTabChanged(2),
                  ),
                ),
                const SizedBox(height: 10),
                CustomerProfileMenuItem(
                  icon: Icons.favorite,
                  label: context.l10n.saved,
                  onTap: () => context.read<CustomerHomeBloc>().add(
                    const CustomerTabChanged(3),
                  ),
                ),
                const SizedBox(height: 10),
                CustomerProfileMenuItem(
                  icon: Icons.credit_card,
                  label: context.l10n.paymentMethods,
                ),
                const SizedBox(height: 10),
                CustomerProfileMenuItem(
                  icon: Icons.notifications,
                  label: context.l10n.notifications,
                  onTap: () => context.push(AppRoutes.NOTIFICATIONS),
                ),
                const SizedBox(height: 10),
                CustomerProfileMenuItem(
                  icon: Icons.chat_bubble_outline,
                  label: context.l10n.messages,
                  badgeCount: state.unreadMessagesCount > 0
                      ? state.unreadMessagesCount
                      : null,
                  onTap: () => context.push(AppRoutes.CHAT_LIST),
                ),
                const SizedBox(height: 10),
                CustomerProfileMenuItem(
                  icon: Icons.language,
                  label: context.l10n.languageAndCurrency,
                  onTap: () => context.push(AppRoutes.LANGUAGE_CURRENCY),
                ),
                const SizedBox(height: 32),
                Text(
                  context.l10n.support,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 16),
                CustomerProfileMenuItem(
                  icon: Icons.help_outline,
                  label: context.l10n.helpCenter,
                  onTap: () => context.push(AppRoutes.HELP_CENTER),
                ),
                const SizedBox(height: 10),
                CustomerProfileMenuItem(
                  icon: Icons.chat_bubble_outline,
                  label: context.l10n.contactUs,
                  onTap: () => context.push(AppRoutes.SUPPORT_TICKETS),
                ),
                const SizedBox(height: 10),
                CustomerProfileMenuItem(
                  icon: Icons.description_outlined,
                  label: context.l10n.termsOfService,
                  onTap: () => context.push(AppRoutes.TERMS_OF_SERVICE),
                ),
                const SizedBox(height: 10),
                CustomerProfileMenuItem(
                  icon: Icons.shield_outlined,
                  label: context.l10n.privacyPolicy,
                  onTap: () => context.push(AppRoutes.PRIVACY_POLICY),
                ),
                const SizedBox(height: 32),
                CustomButton(
                  buttonName: context.l10n.logOut,
                  color: const Color(0xFFDC2626),
                  onPressed: state.isLoading
                      ? null
                      : () => context.read<CustomerProfileCubit>().signOut(),
                  enabled: !state.isLoading,
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
