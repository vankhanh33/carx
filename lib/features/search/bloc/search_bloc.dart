import 'package:carx/data/model/car.dart';
import 'package:carx/features/search/bloc/search_event.dart';
import 'package:carx/features/search/bloc/search_state.dart';
import 'package:carx/service/api/reponsitory/car_reponsitory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  CarReponsitory reponsitory;
  List<Car> carsBase = [];
  SearchBloc(this.reponsitory) : super(SearchInitialState()) {
    on<FetchCarsSearchEvent>(_onFetchCarEvent);
    on<SearchCarsEvent>(_onSearchCarsEvent);
  }

  Future<void> _onFetchCarEvent(
    FetchCarsSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoadingState());
    try {
      final List<Car> cars = await reponsitory.fetchCars();
      carsBase = cars;
      emit(SearchSuccessState(cars));
    } catch (e) {
      emit(SearchErrorState(e.toString()));
    }
  }

  void _onSearchCarsEvent(SearchCarsEvent event, Emitter<SearchState> emit) {
    final String text = event.searchText;

    final currentState = state;
    if (text.isEmpty) {
      if (currentState is SearchSuccessState) {
        emit(currentState);
      } else {
        emit(SearchErrorState('No cars found'));
      }
    } else {
      if (currentState is SearchSuccessState) {
        final List<Car> filteredCars = carsBase
            .where(
              (car) => car.name.toLowerCase().contains(text.toLowerCase()),
            )
            .toList();
        emit(SearchSuccessState(filteredCars));
      }
    }
  }
}
