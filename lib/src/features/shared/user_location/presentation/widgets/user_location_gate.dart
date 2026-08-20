import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/data/models/user_model.dart';
import 'package:aquabook/src/features/shared/user_location/cubit/user_location_cubit.dart';
import 'package:aquabook/src/features/shared/user_location/presentation/widgets/user_location_gate_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLocationGate extends StatelessWidget {
  const UserLocationGate({required this.user, required this.child, super.key});

  final UserModel? user;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UserLocationCubit>(),
      child: UserLocationGateContent(user: user, child: child),
    );
  }
}
