import 'package:multibook/src/features/customer-side/explore/domain/models/explore_collection.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/features/customer-side/explore/presentation/widgets/explore_collection_card.dart';
import 'package:flutter/material.dart';

class ExploreFeaturedCollections extends StatelessWidget {
  const ExploreFeaturedCollections({required this.onSelected, super.key});

  final ValueChanged<ExploreCollection> onSelected;

  List<ExploreCollection> _collections(BuildContext context) => [
    ExploreCollection(
      id: 'romantic_getaways',
      title: context.l10n.romanticGetaways,
      subtitle: context.l10n.perfectForCouples,
      imageUrl:
          'https://images.unsplash.com/photo-1544550285-f813152fb2fd?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreCollection(
      id: 'family_friendly',
      title: context.l10n.familyFriendly,
      subtitle: context.l10n.kidApprovedStays,
      imageUrl:
          'https://images.unsplash.com/photo-1540541338287-41700207dee6?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreCollection(
      id: 'weekend_escapes',
      title: context.l10n.weekendEscapes,
      subtitle: context.l10n.quickCityBreaks,
      imageUrl:
          'https://images.unsplash.com/photo-1485871981521-5b1fd3805eee?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreCollection(
      id: 'beachfront_stays',
      title: context.l10n.beachfrontStays,
      subtitle: context.l10n.oceanViewsIncluded,
      imageUrl:
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreCollection(
      id: 'pet_friendly',
      title: context.l10n.petFriendlyStays,
      subtitle: context.l10n.bringYourBestFriend,
      imageUrl:
          'https://images.unsplash.com/photo-1601758228041-f3b2795255f1?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreCollection(
      id: 'pool_stays',
      title: context.l10n.poolStays,
      subtitle: context.l10n.makeASplash,
      imageUrl:
          'https://images.unsplash.com/photo-1540541338287-41700207dee6?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreCollection(
      id: 'mountain_escapes',
      title: context.l10n.mountainEscapes,
      subtitle: context.l10n.freshAirAndViews,
      imageUrl:
          'https://images.unsplash.com/photo-1510798831971-661eb04b3739?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreCollection(
      id: 'city_breaks',
      title: context.l10n.cityBreaks,
      subtitle: context.l10n.stayCloseToAction,
      imageUrl:
          'https://images.unsplash.com/photo-1519501025264-65ba15a82390?auto=format&fit=crop&w=1000&q=85',
    ),
  ];

  @override
  Widget build(BuildContext context) => Column(
    children: _collections(context)
        .map(
          (collection) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ExploreCollectionCard(
              collection: collection,
              onTap: () => onSelected(collection),
            ),
          ),
        )
        .toList(),
  );
}
