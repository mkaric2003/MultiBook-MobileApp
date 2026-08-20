import 'package:aquabook/src/features/customer-side/explore/domain/models/explore_collection.dart';
import 'package:aquabook/src/features/customer-side/explore/presentation/widgets/explore_collection_card.dart';
import 'package:flutter/material.dart';

class ExploreFeaturedCollections extends StatelessWidget {
  const ExploreFeaturedCollections({required this.onSelected, super.key});

  final ValueChanged<ExploreCollection> onSelected;

  static const _collections = [
    ExploreCollection(
      id: 'romantic_getaways',
      title: 'Romantic getaways',
      subtitle: 'Perfect for couples',
      imageUrl:
          'https://images.unsplash.com/photo-1544550285-f813152fb2fd?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreCollection(
      id: 'family_friendly',
      title: 'Family friendly',
      subtitle: 'Kid-approved stays',
      imageUrl:
          'https://images.unsplash.com/photo-1540541338287-41700207dee6?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreCollection(
      id: 'weekend_escapes',
      title: 'Weekend escapes',
      subtitle: 'Quick city breaks',
      imageUrl:
          'https://images.unsplash.com/photo-1485871981521-5b1fd3805eee?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreCollection(
      id: 'beachfront_stays',
      title: 'Beachfront stays',
      subtitle: 'Ocean views included',
      imageUrl:
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreCollection(
      id: 'pet_friendly',
      title: 'Pet-friendly stays',
      subtitle: 'Bring your best friend',
      imageUrl:
          'https://images.unsplash.com/photo-1601758228041-f3b2795255f1?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreCollection(
      id: 'pool_stays',
      title: 'Pool stays',
      subtitle: 'Make a splash',
      imageUrl:
          'https://images.unsplash.com/photo-1540541338287-41700207dee6?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreCollection(
      id: 'mountain_escapes',
      title: 'Mountain escapes',
      subtitle: 'Fresh air and stunning views',
      imageUrl:
          'https://images.unsplash.com/photo-1510798831971-661eb04b3739?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreCollection(
      id: 'city_breaks',
      title: 'City breaks',
      subtitle: 'Stay close to the action',
      imageUrl:
          'https://images.unsplash.com/photo-1519501025264-65ba15a82390?auto=format&fit=crop&w=1000&q=85',
    ),
  ];

  @override
  Widget build(BuildContext context) => Column(
    children: _collections
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
