abstract class OrderManagementDetailState {}

class OrderManagementDetailInitialState extends OrderManagementDetailState {}

class CancelOrderLoadingState extends OrderManagementDetailState {}

class CancelledOrderSuccessState extends OrderManagementDetailState {}

class CancelOrderFailureState extends OrderManagementDetailState {
  String messageError;
  CancelOrderFailureState({required this.messageError});
}
