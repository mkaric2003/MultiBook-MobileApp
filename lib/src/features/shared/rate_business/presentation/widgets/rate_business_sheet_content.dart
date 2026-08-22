import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/shared/rate_business/cubit/rate_business_cubit.dart';
import 'package:aquabook/src/features/shared/rate_business/cubit/rate_business_state.dart';
import 'package:aquabook/src/features/shared/rate_business/domain/models/rate_business_target.dart';
import 'package:aquabook/src/features/shared/rate_business/presentation/widgets/rating_star_selector.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:toastification/toastification.dart';

class RateBusinessSheetContent extends HookWidget {
  const RateBusinessSheetContent({required this.target, super.key});

  final RateBusinessTarget target;

  @override
  Widget build(BuildContext context) {
    final rating = useState(0);
    final commentController = useTextEditingController();

    return BlocConsumer<RateBusinessCubit, RateBusinessState>(
      listener: (context, state) {
        if (state.isSubmitted) Navigator.of(context).pop(true);
        if (state.errorMessage != null) {
          toastification.show(
            context: context,
            alignment: Alignment.bottomCenter,
            autoCloseDuration: const Duration(seconds: 3),
            type: ToastificationType.error,
            title: Text(context.l10n.couldNotSubmitReview),
          );
        }
      },
      builder: (context, state) => SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            22,
            24,
            24 + MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              const SizedBox(height: 22),
              Text(
                context.l10n.rateYourExperience,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                target.businessName,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.muted, fontSize: 15),
              ),
              const SizedBox(height: 24),
              Text(
                context.l10n.howWasYourExperience,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              RatingStarSelector(
                rating: rating.value,
                onChanged: (value) => rating.value = value,
              ),
              const SizedBox(height: 18),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.l10n.writeReviewOptional,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: commentController,
                minLines: 3,
                maxLines: 5,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: false,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: context.l10n.shareYourExperience,
                  hintStyle: const TextStyle(color: AppColors.muted),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                buttonName: context.l10n.submitReview,
                enabled: rating.value > 0 && !state.isSubmitting,
                onPressed: () => context.read<RateBusinessCubit>().submit(
                  target: target,
                  rating: rating.value,
                  comment: commentController.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
