import 'package:flutter/material.dart';
import 'package:multibook/src/core/theme/app_colors.dart';

class ClientPlaceholderView extends StatelessWidget {
  const ClientPlaceholderView({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$title placeholder',
        style: TextStyle(color: context.appPalette.foreground, fontSize: 18),
      ),
    );
  }
}
