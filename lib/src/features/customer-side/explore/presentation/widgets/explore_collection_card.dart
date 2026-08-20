import 'package:aquabook/src/features/customer-side/explore/domain/models/explore_collection.dart';
import 'package:flutter/material.dart';

class ExploreCollectionCard extends StatelessWidget {
  const ExploreCollectionCard({super.key, required this.collection});

  final ExploreCollection collection;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 165,
    width: double.infinity,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(collection.imageUrl, fit: BoxFit.cover),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xC9000000)],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    collection.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    collection.subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
