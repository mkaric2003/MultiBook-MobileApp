import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:multibook/src/features/customer-side/dashboard/presentation/widgets/customer_home_tab_selector.dart';
import 'package:multibook/src/features/customer-side/search/cubit/customer_search_cubit.dart';
import 'package:multibook/src/features/customer-side/search/cubit/customer_search_state.dart';
import 'package:multibook/src/features/customer-side/search/presentation/widgets/search_app_bar.dart';
import 'package:multibook/src/features/customer-side/search/presentation/widgets/customer_search_results_list.dart';
import 'package:multibook/src/features/customer-side/search/presentation/widgets/customer_service_search_results_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class CustomerSearchView extends HookWidget {
  const CustomerSearchView({
    this.initialTab = CustomerHomeTab.stays,
    super.key,
  });

  final CustomerHomeTab initialTab;

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final searchFocusNode = useFocusNode();

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => searchFocusNode.requestFocus(),
      );
      return null;
    }, [searchFocusNode]);

    return BlocProvider(
      create: (_) => getIt<CustomerSearchCubit>()..selectTab(initialTab),
      child: BlocBuilder<CustomerSearchCubit, CustomerSearchState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  children: [
                    SearchAppBar(
                      controller: searchController,
                      focusNode: searchFocusNode,
                      onChanged: context.read<CustomerSearchCubit>().search,
                      onBackPressed: () => context.pop(),
                      hintText: state.selectedTab == CustomerHomeTab.stays
                          ? 'Where do you want to stay?'
                          : 'What service do you need?',
                    ),
                    const SizedBox(height: 24),
                    CustomerHomeTabSelector(
                      selectedTab: state.selectedTab,
                      onChanged: context.read<CustomerSearchCubit>().selectTab,
                    ),
                    Expanded(
                      child: state.selectedTab == CustomerHomeTab.stays
                          ? CustomerSearchResultsList(
                              query: state.query,
                              stays: state.stays,
                              isLoading: state.isLoading,
                            )
                          : CustomerServiceSearchResultsList(
                              query: state.query,
                              services: state.services,
                              isLoading: state.isLoading,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
