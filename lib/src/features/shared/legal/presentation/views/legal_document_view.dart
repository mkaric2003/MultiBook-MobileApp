import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/features/shared/legal/domain/enums/legal_document_type.dart';
import 'package:aquabook/src/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class LegalDocumentView extends StatelessWidget {
  const LegalDocumentView({required this.documentType, super.key});

  final LegalDocumentType documentType;

  @override
  Widget build(BuildContext context) {
    final title = switch (documentType) {
      LegalDocumentType.termsOfService => context.l10n.termsOfService,
      LegalDocumentType.privacyPolicy => context.l10n.privacyPolicy,
    };
    final content = switch (documentType) {
      LegalDocumentType.termsOfService => context.l10n.termsOfServiceContent,
      LegalDocumentType.privacyPolicy => context.l10n.privacyPolicyContent,
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
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: Color(0xFFD1D5DB),
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
