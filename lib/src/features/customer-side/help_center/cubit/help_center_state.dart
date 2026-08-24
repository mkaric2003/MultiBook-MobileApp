import 'package:aquabook/src/features/customer-side/help_center/domain/models/help_article_model.dart';
import 'package:aquabook/src/features/customer-side/help_center/domain/enums/help_center_topic.dart';

final class HelpCenterState {
  const HelpCenterState({
    this.query = '',
    this.topic,
    this.articles = const [],
  });

  final String query;
  final HelpCenterTopic? topic;
  final List<HelpArticleModel> articles;

  HelpCenterState copyWith({
    String? query,
    HelpCenterTopic? topic,
    bool clearTopic = false,
    List<HelpArticleModel>? articles,
  }) => HelpCenterState(
    query: query ?? this.query,
    topic: clearTopic ? null : topic ?? this.topic,
    articles: articles ?? this.articles,
  );
}
