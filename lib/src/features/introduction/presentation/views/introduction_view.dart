import 'package:aquabook/src/features/introduction/cubit/countries_cubit.dart';
import 'package:aquabook/src/features/introduction/cubit/countries_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class IntroductionView extends HookWidget {
  const IntroductionView({super.key});

  @override
  Widget build(BuildContext context) {
    final queryController = useTextEditingController();
    return BlocProvider(
      create: (context) => CountriesCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: DefaultTabController(
              length: 2,
              child: TabBarView(
                children: [
                  Column(
                    spacing: 15,
                    children: [
                      BlocBuilder<CountriesCubit, CountriesState>(
                        builder: (context, state) {
                          return TextField(
                            controller: queryController,
                            decoration: InputDecoration(
                              hintText: 'Search countries...',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onChanged: (value) {
                              context.read<CountriesCubit>().searchCountries(
                                value,
                              );
                            },
                          );
                        },
                      ),
                      Expanded(
                        child: BlocBuilder<CountriesCubit, CountriesState>(
                          builder: (context, state) {
                            if (state.isLoading) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (state.countries.isEmpty) {
                              return Center(child: Text('No countries found'));
                            }
                            return RefreshIndicator(
                              onRefresh: () => context
                                  .read<CountriesCubit>()
                                  .fetchCountries(),
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 280,
                                      mainAxisSpacing: 12,
                                      crossAxisSpacing: 12,
                                      childAspectRatio: 1.25,
                                    ),
                                itemCount: state.countries.length,
                                itemBuilder: (context, index) {
                                  final country = state.countries[index];
                                  return Card(
                                    elevation: 1.5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              country.name.common,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            'Capital: ${country.capital?.join(', ') ?? 'N/A'}',
                                          ),
                                          const Spacer(),
                                          Text(
                                            'Area: ${country.area?.toStringAsFixed(0)} km²',
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  //second tab
                  Center(child: Text('Second Tab Content')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
