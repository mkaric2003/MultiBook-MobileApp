import 'package:aquabook/src/features/customer-side/help_center/cubit/help_center_state.dart';
import 'package:aquabook/src/features/customer-side/help_center/domain/data/help_center_articles.dart';
import 'package:aquabook/src/features/customer-side/help_center/domain/enums/help_center_topic.dart';
import 'package:aquabook/src/features/customer-side/help_center/domain/models/help_article_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HelpCenterCubit extends Cubit<HelpCenterState> {
  HelpCenterCubit()
    : super(const HelpCenterState(articles: helpCenterArticles));

  void search({
    required String query,
    required bool Function(HelpArticleModel) matches,
  }) {
    final normalizedQuery = query.trim();
    emit(
      HelpCenterState(
        query: normalizedQuery,
        articles: helpCenterArticles
            .where((article) => normalizedQuery.isEmpty || matches(article))
            .toList(),
      ),
    );
  }

  void filterByTopic(HelpCenterTopic topic) => emit(
    HelpCenterState(
      topic: topic,
      articles: helpCenterArticles
          .where((article) => article.topic == topic)
          .toList(),
    ),
  );

  void showAll() => emit(const HelpCenterState(articles: helpCenterArticles));
}
