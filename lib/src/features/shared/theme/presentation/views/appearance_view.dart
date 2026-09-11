import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/shared/theme/cubit/theme_cubit.dart';
import 'package:multibook/src/features/shared/theme/cubit/theme_state.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';

class AppearanceView extends StatelessWidget {
  const AppearanceView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.appPalette.background,
    body: SafeArea(
      child: Column(
        children: [
          CustomAppBar(title: context.l10n.appearance),
          Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) => Container(
                decoration: BoxDecoration(
                  color: context.appPalette.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: context.appPalette.border),
                ),
                child: SwitchListTile.adaptive(
                  value: state.isLight,
                  activeThumbColor: AppColors.primary,
                  title: Text(
                    context.l10n.lightTheme,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    context.l10n.lightThemeDescription,
                    style: TextStyle(color: context.appPalette.muted),
                  ),
                  secondary: Icon(
                    state.isLight
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded,
                    color: AppColors.primary,
                  ),
                  onChanged: (value) => context
                      .read<ThemeCubit>()
                      .setLightTheme(isLight: value),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
