import 'package:aquabook/src/features/customer-side/explore/domain/models/explore_collection.dart';
import 'package:aquabook/src/features/customer-side/explore/presentation/widgets/explore_collection_card.dart';
import 'package:flutter/material.dart';

class ExploreFeaturedCollections extends StatelessWidget {
  const ExploreFeaturedCollections({super.key});

  static const _collections = [
    ExploreCollection(
      title: 'Romantic getaways',
      subtitle: 'Perfect for couples',
      imageUrl:
          'https://images.unsplash.com/photo-1544550285-f813152fb2fd?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreCollection(
      title: 'Family friendly',
      subtitle: 'Kid-approved stays',
      imageUrl:
          'https://images.unsplash.com/photo-1540541338287-41700207dee6?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreCollection(
      title: 'Weekend escapes',
      subtitle: 'Quick city breaks',
      imageUrl:
          'https://images.unsplash.com/photo-1485871981521-5b1fd3805eee?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreCollection(
      title: 'Beachfront stays',
      subtitle: 'Ocean views included',
      imageUrl:
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1000&q=85',
    ),
  ];

  @override
  Widget build(BuildContext context) => Column(
    children: _collections
        .map(
          (collection) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ExploreCollectionCard(collection: collection),
          ),
        )
        .toList(),
  );
}
