import 'package:flutter/material.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/models/featured_collection_model.dart';
import 'package:multibook/src/features/customer-side/explore/domain/models/explore_service_collection.dart';

class ExploreServiceCollections extends StatelessWidget {
  const ExploreServiceCollections({
    required this.collections,
    required this.onSelected,
    super.key,
  });

  final List<FeaturedCollectionModel> collections;
  final ValueChanged<ExploreServiceCollection> onSelected;

  @override
  Widget build(BuildContext context) => Column(
    children: collections.map((item) {
      final collection = ExploreServiceCollection(
        id: item.id,
        title: _text(context, item.titleKey),
        subtitle: _text(context, item.subtitleKey),
        imageUrl: item.imageUrl,
      );
      return Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Material(
            color: AppColors.surface,
            child: InkWell(
              onTap: () => onSelected(collection),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    collection.imageUrl,
                    height: 90,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          collection.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          collection.subtitle,
                          style: const TextStyle(
                            color: AppColors.muted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList(),
  );

  String _text(BuildContext context, String key) => switch (key) {
    'wellnessAndSpa' => context.l10n.wellnessAndSpa,
    'relaxAndRejuvenate' => context.l10n.relaxAndRejuvenate,
    'beautyAndGrooming' => context.l10n.beautyAndGrooming,
    'lookYourBest' => context.l10n.lookYourBest,
    'homeRepairs' => context.l10n.homeRepairs,
    'fixItRight' => context.l10n.fixItRight,
    'autoServices' => context.l10n.autoServices,
    'keepMoving' => context.l10n.keepMoving,
    'healthAndCare' => context.l10n.healthAndCare,
    'feelYourBest' => context.l10n.feelYourBest,
    'learnAndGrow' => context.l10n.learnAndGrow,
    'buildNewSkills' => context.l10n.buildNewSkills,
    'petCare' => context.l10n.petCare,
    'careForEveryCompanion' => context.l10n.careForEveryCompanion,
    'professionalServices' => context.l10n.professionalServices,
    'expertSupportWhenNeeded' => context.l10n.expertSupportWhenNeeded,
    _ => key,
  };
}
