import 'package:aquabook/app.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/features/customer-side/help_center/domain/models/help_article_model.dart';
import 'package:aquabook/src/global_widgets/custom_app_bar.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HelpArticleDetailView extends StatelessWidget {
  const HelpArticleDetailView({required this.article, super.key});

  final HelpArticleModel article;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      bottom: false,
      child: Column(
        children: [
          CustomAppBar(title: context.l10n.helpArticleTitle(article.id)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.helpTopicTitle(article.topic),
                    style: const TextStyle(
                      color: Color(0xFF8B5CF6),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    context.l10n.helpArticleTitle(article.id),
                    style: const TextStyle(
                      fontSize: 25,
                      height: 1.15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    context.l10n.helpArticleSummary(article.id),
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 26),
                  SelectableText(
                    context.l10n.helpArticleBody(article.id),
                    style: const TextStyle(
                      color: Color(0xFFD1D5DB),
                      fontSize: 15,
                      height: 1.65,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    buttonName: context.l10n.helpCenterContactButton,
                    onPressed: () => context.push(AppRoutes.SUPPORT_TICKETS),
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
