import 'package:multibook/src/features/customer-side/help_center/domain/enums/help_article_id.dart';
import 'package:multibook/src/features/customer-side/help_center/domain/enums/help_center_topic.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'help_article_model.mapper.dart';

@MappableClass()
final class HelpArticleModel with HelpArticleModelMappable {
  const HelpArticleModel({required this.id, required this.topic});

  final HelpArticleId id;
  final HelpCenterTopic topic;
}
