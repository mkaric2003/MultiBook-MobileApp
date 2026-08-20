import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/explore/domain/models/explore_service_collection.dart';
import 'package:flutter/material.dart';

class ExploreServiceCollections extends StatelessWidget {
  const ExploreServiceCollections({required this.onSelected, super.key});

  final ValueChanged<ExploreServiceCollection> onSelected;

  static const _collections = [
    ExploreServiceCollection(
      id: 'wellness_spa',
      title: 'Wellness & Spa',
      subtitle: 'Relax and rejuvenate',
      imageUrl:
          'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreServiceCollection(
      id: 'beauty_grooming',
      title: 'Beauty & Grooming',
      subtitle: 'Look your best',
      imageUrl:
          'https://images.unsplash.com/photo-1562322140-8baeececf3df?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreServiceCollection(
      id: 'home_repairs',
      title: 'Home Repairs',
      subtitle: 'Fix it right',
      imageUrl:
          'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreServiceCollection(
      id: 'auto_services',
      title: 'Auto Services',
      subtitle: 'Keep moving',
      imageUrl:
          'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreServiceCollection(
      id: 'health_care',
      title: 'Health & Care',
      subtitle: 'Feel your best',
      imageUrl:
          'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreServiceCollection(
      id: 'learn_grow',
      title: 'Learn & Grow',
      subtitle: 'Build new skills',
      imageUrl:
          'https://images.unsplash.com/photo-1523240795612-9a054b0db644?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreServiceCollection(
      id: 'pet_care',
      title: 'Pet Care',
      subtitle: 'Care for every companion',
      imageUrl:
          'https://images.unsplash.com/photo-1551884831-bbf3cdc6469e?auto=format&fit=crop&w=1000&q=85',
    ),
    ExploreServiceCollection(
      id: 'professional_services',
      title: 'Professional Services',
      subtitle: 'Expert support when needed',
      imageUrl:
          'https://images.unsplash.com/photo-1450101499163-c8848c66ca85?auto=format&fit=crop&w=1000&q=85',
    ),
  ];

  @override
  Widget build(BuildContext context) => Column(
    children: _collections
        .map(
          (collection) => Padding(
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
          ),
        )
        .toList(),
  );
}
