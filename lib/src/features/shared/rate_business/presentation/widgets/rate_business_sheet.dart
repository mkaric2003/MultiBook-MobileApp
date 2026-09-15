import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/features/shared/rate_business/cubit/rate_business_cubit.dart';
import 'package:multibook/src/features/shared/rate_business/domain/models/rate_business_target.dart';
import 'package:multibook/src/features/shared/rate_business/presentation/widgets/rate_business_sheet_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RateBusinessSheet extends StatelessWidget {
  const RateBusinessSheet({required this.target, super.key});

  final RateBusinessTarget target;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<RateBusinessCubit>(),
    child: RateBusinessSheetContent(target: target),
  );
}
