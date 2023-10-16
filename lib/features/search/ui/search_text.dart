import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carx/components/item_car.dart';
import 'package:carx/data/model/car.dart';
import 'package:carx/features/search/bloc/search_bloc.dart';
import 'package:carx/features/search/bloc/search_event.dart';
import 'package:carx/features/search/bloc/search_state.dart';
import 'package:carx/service/api/reponsitory/car_reponsitory.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late SearchBloc bloc;
  TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    bloc = SearchBloc(CarReponsitory.response());
    bloc.add(FetchCarsSearchEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search For Cars'),
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocConsumer<SearchBloc, SearchState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is SearchLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SearchSuccessState) {
              List<Car> cars = state.cars;
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: _searchTextController,
                          decoration: const InputDecoration(
                            hintText: 'Search....',
                          ),
                           onSubmitted: (value) {
                             bloc.add(SearchCarsEvent(value));
                           },
                        ),
                        suggestionsCallback: (pattern) async {
                          return await CarReponsitory.getSuggestions(
                              pattern, bloc.carsBase);
                        },

                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        noItemsFoundBuilder: (context) {
                          return const ListTile(
                            title: Text('No suggestions found.'),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          _searchTextController.text = suggestion;
                          bloc.add(SearchCarsEvent(suggestion));
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: const TextSpan(
                              text: 'Result for',
                              children: [
                                TextSpan(text: ' " '),
                                TextSpan(text: 'Lamborghini'),
                                TextSpan(text: ' " '),
                              ],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(text: '1'),
                                TextSpan(text: ' '),
                                TextSpan(text: 'found'),
                              ],
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cars.length,
                        itemBuilder: (context, index) {
                          return Align(
                            alignment: Alignment.center,
                            child: ItemCar(car: cars.elementAt(index)),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisExtent: 280,
                          mainAxisSpacing: 16.0,
                          crossAxisSpacing: 16.0,
                          childAspectRatio: 1.0,
                          maxCrossAxisExtent: 300,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            } else if (state is SearchErrorState) {
              return Center(child: Text(state.errorMessage));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
