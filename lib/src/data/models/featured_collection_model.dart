import 'package:dart_mappable/dart_mappable.dart';

part 'featured_collection_model.mapper.dart';

@MappableClass()
class FeaturedCollectionModel with FeaturedCollectionModelMappable {
  const FeaturedCollectionModel({
    required this.id,
    required this.titleKey,
    required this.subtitleKey,
    required this.imageUrl,
  });

  static FeaturedCollectionModel fromMap(Map<String, dynamic> map) =>
      FeaturedCollectionModelMapper.fromMap(map);

  final String id;
  final String titleKey;
  final String subtitleKey;
  final String imageUrl;
}
