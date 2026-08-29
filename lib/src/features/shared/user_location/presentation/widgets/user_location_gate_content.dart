import 'package:multibook/src/data/models/user_model.dart';
import 'package:multibook/src/features/shared/user_location/cubit/user_location_cubit.dart';
import 'package:multibook/src/features/shared/user_location/cubit/user_location_state.dart';
import 'package:multibook/src/features/shared/user_location/presentation/widgets/user_location_error_dialog.dart';
import 'package:multibook/src/features/shared/user_location/presentation/widgets/user_location_permission_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UserLocationGateContent extends HookWidget {
  const UserLocationGateContent({
    required this.user,
    required this.child,
    super.key,
  });

  final UserModel? user;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<UserLocationCubit>().initialize(user),
      );
      return null;
    }, [user?.id]);

    return BlocListener<UserLocationCubit, UserLocationState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          (current.status == UserLocationStatus.needsPermission ||
              current.status == UserLocationStatus.error),
      listener: (context, state) async {
        final cubit = context.read<UserLocationCubit>();
        if (state.status == UserLocationStatus.needsPermission) {
          final shouldUseLocation = await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (_) => const UserLocationPermissionDialog(),
          );
          if (!context.mounted) return;
          if (shouldUseLocation ?? false) {
            await cubit.useCurrentLocation();
          } else {
            cubit.skip();
          }
          return;
        }

        await showDialog<void>(
          context: context,
          builder: (dialogContext) => UserLocationErrorDialog(
            message:
                state.errorMessage ??
                'We could not save your current location.',
            canOpenSettings: state.canOpenSettings,
            onOpenSettings: () {
              Navigator.of(dialogContext).pop();
              cubit.openAppSettings();
            },
          ),
        );
        if (context.mounted) cubit.skip();
      },
      child: child,
    );
  }
}
