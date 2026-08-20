import 'package:aquabook/app.dart';
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
                    const Expanded(
                      child: Text(
                        'Profile',
                        style: TextStyle(
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
                        user?.fullName ?? 'Profile',
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
                  buttonName: 'Edit profile',
                  onPressed: () =>
                      context.push(AppRoutes.CUSTOMER_EDIT_PROFILE),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Account',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 16),
                CustomerProfileMenuItem(
                  icon: Icons.calendar_month,
                  label: 'My bookings',
                  onTap: () => context.read<CustomerHomeBloc>().add(
                    const CustomerTabChanged(2),
                  ),
                ),
                const SizedBox(height: 10),
                CustomerProfileMenuItem(
                  icon: Icons.favorite,
                  label: 'Saved',
                  onTap: () => context.read<CustomerHomeBloc>().add(
                    const CustomerTabChanged(3),
                  ),
                ),
                const SizedBox(height: 10),
                const CustomerProfileMenuItem(
                  icon: Icons.credit_card,
                  label: 'Payment methods',
                ),
                const SizedBox(height: 10),
                CustomerProfileMenuItem(
                  icon: Icons.notifications,
                  label: 'Notifications',
                  onTap: () => context.push(AppRoutes.NOTIFICATIONS),
                ),
                const SizedBox(height: 10),
                CustomerProfileMenuItem(
                  icon: Icons.chat_bubble_outline,
                  label: 'Messages',
                  badgeCount: state.unreadMessagesCount > 0
                      ? state.unreadMessagesCount
                      : null,
                  onTap: () => context.push(AppRoutes.CHAT_LIST),
                ),
                const SizedBox(height: 10),
                const CustomerProfileMenuItem(
                  icon: Icons.language,
                  label: 'Language & currency',
                ),
                const SizedBox(height: 32),
                const Text(
                  'Support',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 16),
                const CustomerProfileMenuItem(
                  icon: Icons.help_outline,
                  label: 'Help Center',
                ),
                const SizedBox(height: 10),
                const CustomerProfileMenuItem(
                  icon: Icons.chat_bubble_outline,
                  label: 'Contact us',
                ),
                const SizedBox(height: 10),
                const CustomerProfileMenuItem(
                  icon: Icons.description_outlined,
                  label: 'Terms of Service',
                ),
                const SizedBox(height: 10),
                const CustomerProfileMenuItem(
                  icon: Icons.shield_outlined,
                  label: 'Privacy Policy',
                ),
                const SizedBox(height: 32),
                CustomButton(
                  buttonName: 'Log out',
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
