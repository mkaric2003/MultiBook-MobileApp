import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/features/business-side/add_business/presentation/views/add_business_view.dart';
import 'package:multibook/src/features/business-side/manage_catalog/bloc/manage_catalog_cubit.dart';
import 'package:multibook/src/features/business-side/manage_catalog/bloc/manage_catalog_state.dart';
import 'package:multibook/src/features/business-side/manage_catalog/presentation/widgets/manage_catalog_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Resolves the selected business and opens the complete, pre-filled editor.
class ManageCatalogView extends StatelessWidget {
  const ManageCatalogView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<ManageCatalogCubit>()..load(),
    child: BlocBuilder<ManageCatalogCubit, ManageCatalogState>(
      builder: (context, state) {
        if (state.isLoading) return const ManageCatalogSkeleton();
        final business = state.business;
        if (business != null) return AddBusinessView(editingBusiness: business);
        return Scaffold(body: Center(child: Text(state.errorMessage ?? '')));
      },
    ),
  );
}
