import 'package:carx/data/reponsitories/api/order_reponsitory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_management_detail_event.dart';
import 'order_management_detail_state.dart';

class OrderManagementDetailBloc
    extends Bloc<OrderManagementDetailEvent, OrderManagementDetailState> {
  OrderManagementDetailBloc(OrderReponsitory reponsitory)
      : super(OrderManagementDetailInitialState()) {
    on<OrderCancellationEvent>(
      (event, emit) async {
        emit(CancelOrderLoadingState());
        try {
          await reponsitory.updateOrder(
            order: event.order,
            status: 'Cancelled',
          );
          emit(CancelledOrderSuccessState());
        } catch (e) {
          emit(CancelOrderFailureState(messageError: e.toString()));
        }
      },
    );
  }
}
