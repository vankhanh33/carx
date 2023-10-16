import 'package:bloc/bloc.dart';
import 'package:carx/features/car/bloc/car_event.dart';
import 'package:carx/features/car/bloc/car_state.dart';
import 'package:carx/data/model/car.dart';
import 'package:carx/service/api/reponsitory/car_reponsitory.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  CarBloc(CarReponsitory carRepository) : super(CarInitial()) {
    on<FetchCars>(
      (event, emit) async {
        emit(CarLoading());
        try {
          final List<Car> cars =
              await carRepository.fetchCars();
          emit(CarSuccess(cars: cars));
       
        } catch (e) {
          emit(CarFailure(error: e.toString()));
        }
      },
    );
  }

  // Stream<CarState> mapEventToState(CarEvent event) async* {
  //   if (event is FetchCars) {
  //     yield CarLoading();

  //     try {
  //       final List<Car> cars = await carRepository.fetchCars();
  //       yield CarSuccess(cars: cars);
  //     } catch (e) {
  //       yield CarFailure(error: e.toString());
  //     }
  //   }
  // }
}
