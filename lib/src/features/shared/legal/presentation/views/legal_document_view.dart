import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/shared/legal/domain/enums/legal_document_type.dart';
import 'package:multibook/src/features/shared/legal/domain/enums/legal_document_audience.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class LegalDocumentView extends StatelessWidget {
  const LegalDocumentView({
    required this.documentType,
    this.audience = LegalDocumentAudience.customer,
    super.key,
  });

  final LegalDocumentType documentType;
  final LegalDocumentAudience audience;

  @override
  Widget build(BuildContext context) {
    final title = switch (documentType) {
      LegalDocumentType.termsOfService => context.l10n.termsOfService,
      LegalDocumentType.privacyPolicy => context.l10n.privacyPolicy,
    };
    final content = switch ((audience, documentType)) {
      (LegalDocumentAudience.customer, LegalDocumentType.termsOfService) =>
        context.l10n.termsOfServiceContent,
      (LegalDocumentAudience.customer, LegalDocumentType.privacyPolicy) =>
        context.l10n.privacyPolicyContent,
      (LegalDocumentAudience.provider, LegalDocumentType.termsOfService) =>
        context.l10n.providerTermsOfServiceContent,
      (LegalDocumentAudience.provider, LegalDocumentType.privacyPolicy) =>
        context.l10n.providerPrivacyPolicyContent,
    };

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustomAppBar(title: title),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
                child: SelectableText(
                  content,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: context.appPalette.foreground,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
