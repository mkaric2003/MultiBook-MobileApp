import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class DashboardEmptyState extends StatelessWidget {
  const DashboardEmptyState({super.key, required this.onAddBusiness});

  final VoidCallback onAddBusiness;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 76,
                width: 76,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.storefront_outlined,
                  size: 38,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                context.l10n.noBusinessesYet,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                context.l10n.createBusinessToStart,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.muted, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 12, 25, 24),
          child: CustomButton(
            buttonName: context.l10n.addNewBusiness,
            leadingIcon: const Icon(Icons.add),
            onPressed: onAddBusiness,
          ),
        ),
      ),
    );
  }
}
