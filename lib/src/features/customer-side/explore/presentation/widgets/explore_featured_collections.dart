import 'package:flutter/material.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/data/models/featured_collection_model.dart';
import 'package:multibook/src/features/customer-side/explore/domain/models/explore_collection.dart';
import 'package:multibook/src/features/customer-side/explore/presentation/widgets/explore_collection_card.dart';

class ExploreFeaturedCollections extends StatelessWidget {
  const ExploreFeaturedCollections({
    required this.collections,
    required this.onSelected,
    super.key,
  });

  final List<FeaturedCollectionModel> collections;
  final ValueChanged<ExploreCollection> onSelected;

  @override
  Widget build(BuildContext context) => Column(
    children: collections.map((item) {
      final collection = ExploreCollection(
        id: item.id,
        title: _text(context, item.titleKey),
        subtitle: _text(context, item.subtitleKey),
        imageUrl: item.imageUrl,
      );
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: ExploreCollectionCard(
          collection: collection,
          onTap: () => onSelected(collection),
        ),
      );
    }).toList(),
  );

  String _text(BuildContext context, String key) => switch (key) {
    'romanticGetaways' => context.l10n.romanticGetaways,
    'perfectForCouples' => context.l10n.perfectForCouples,
    'familyFriendly' => context.l10n.familyFriendly,
    'kidApprovedStays' => context.l10n.kidApprovedStays,
    'weekendEscapes' => context.l10n.weekendEscapes,
    'quickCityBreaks' => context.l10n.quickCityBreaks,
    'beachfrontStays' => context.l10n.beachfrontStays,
    'oceanViewsIncluded' => context.l10n.oceanViewsIncluded,
    'petFriendlyStays' => context.l10n.petFriendlyStays,
    'bringYourBestFriend' => context.l10n.bringYourBestFriend,
    'poolStays' => context.l10n.poolStays,
    'makeASplash' => context.l10n.makeASplash,
    'mountainEscapes' => context.l10n.mountainEscapes,
    'freshAirAndViews' => context.l10n.freshAirAndViews,
    'cityBreaks' => context.l10n.cityBreaks,
    'stayCloseToAction' => context.l10n.stayCloseToAction,
    _ => key,
  };
}
