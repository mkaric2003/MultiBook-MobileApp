import 'package:aquabook/app.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/help_center/cubit/help_center_cubit.dart';
import 'package:aquabook/src/features/customer-side/help_center/cubit/help_center_state.dart';
import 'package:aquabook/src/features/customer-side/help_center/domain/enums/help_center_topic.dart';
import 'package:aquabook/src/features/customer-side/help_center/presentation/widgets/help_center_article_tile.dart';
import 'package:aquabook/src/features/customer-side/help_center/presentation/widgets/help_center_contact_card.dart';
import 'package:aquabook/src/features/customer-side/help_center/presentation/widgets/help_center_empty_state.dart';
import 'package:aquabook/src/features/customer-side/help_center/presentation/widgets/help_center_search_field.dart';
import 'package:aquabook/src/features/customer-side/help_center/presentation/widgets/help_center_topic_card.dart';
import 'package:aquabook/src/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HelpCenterView extends StatelessWidget {
  const HelpCenterView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => HelpCenterCubit(),
    child: Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustomAppBar(title: context.l10n.helpCenter),
            Expanded(
              child: BlocBuilder<HelpCenterCubit, HelpCenterState>(
                builder: (context, state) => SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.helpCenterHeading,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        context.l10n.helpCenterIntro,
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontSize: 14,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 20),
                      HelpCenterSearchField(
                        onChanged: (query) =>
                            context.read<HelpCenterCubit>().search(
                              query: query,
                              matches: (article) {
                                final title = context.l10n.helpArticleTitle(
                                  article.id,
                                );
                                final summary = context.l10n.helpArticleSummary(
                                  article.id,
                                );
                                return '$title $summary'.toLowerCase().contains(
                                  query.trim().toLowerCase(),
                                );
                              },
                            ),
                      ),
                      const SizedBox(height: 28),
                      if (state.query.isEmpty && state.topic == null) ...[
                        Text(
                          context.l10n.helpCenterBrowseTopics,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 14),
                        GridView.builder(
                          itemCount: HelpCenterTopic.values.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 1.65,
                              ),
                          itemBuilder: (context, index) {
                            final topic = HelpCenterTopic.values[index];
                            return HelpCenterTopicCard(
                              icon: _topicIcon(topic),
                              title: context.l10n.helpTopicTitle(topic),
                              onTap: () => context
                                  .read<HelpCenterCubit>()
                                  .filterByTopic(topic),
                            );
                          },
                        ),
                        const SizedBox(height: 28),
                      ],
                      if (state.topic != null) ...[
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                context.l10n.helpTopicTitle(state.topic!),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: context
                                  .read<HelpCenterCubit>()
                                  .showAll,
                              child: Text(context.l10n.helpCenterShowAll),
                            ),
                          ],
                        ),
                      ] else
                        Text(
                          state.query.isEmpty
                              ? context.l10n.helpCenterPopularArticles
                              : context.l10n.helpCenterSearchResults,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      const SizedBox(height: 14),
                      if (state.articles.isEmpty)
                        const HelpCenterEmptyState()
                      else
                        ...state.articles.map(
                          (article) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: HelpCenterArticleTile(
                              title: context.l10n.helpArticleTitle(article.id),
                              summary: context.l10n.helpArticleSummary(
                                article.id,
                              ),
                              onTap: () => context.push(
                                AppRoutes.HELP_ARTICLE_DETAIL,
                                extra: article,
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 22),
                      HelpCenterContactCard(
                        onContactPressed: () =>
                            context.push(AppRoutes.SUPPORT_TICKETS),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

IconData _topicIcon(HelpCenterTopic topic) => switch (topic) {
  HelpCenterTopic.stays => Icons.hotel_outlined,
  HelpCenterTopic.appointments => Icons.calendar_month_outlined,
  HelpCenterTopic.changesAndCancellations => Icons.event_busy_outlined,
  HelpCenterTopic.payments => Icons.payments_outlined,
  HelpCenterTopic.accountAndPrivacy => Icons.manage_accounts_outlined,
  HelpCenterTopic.messagesAndNotifications => Icons.forum_outlined,
  HelpCenterTopic.technicalSupport => Icons.tune_outlined,
  HelpCenterTopic.safetyAndSupport => Icons.shield_outlined,
};
