import 'package:bloc/bloc.dart';
import 'package:carx/data/features/car/bloc/car_event.dart';
import 'package:carx/data/features/car/bloc/car_state.dart';
import 'package:carx/data/model/car.dart';

import 'package:carx/data/reponsitories/car_reponsitory.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  CarBloc(CarReponsitory reponsitory) : super(CarInitial()) {
    on<FetchCars>(
      (event, emit) async {
        emit(CarLoading());
        try {
          final List<Car> cars =
              await reponsitory.fetchCars();
          emit(CarSuccess(cars: cars));
       
        } catch (e) {
          emit(CarFailure(error: e.toString()));
        }
      },
    );
  }

}
