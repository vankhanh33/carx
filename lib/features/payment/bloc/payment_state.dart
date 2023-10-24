import 'package:carx/data/model/order.dart';

enum PaymentStatus { initial, loading, success, failure }

class PaymentState {
  final String selectedPaymentMethod;
  final PaymentStatus status;
  final String errorText;
  final bool isOnClick;
  final Order? order;

  const PaymentState({
    required this.selectedPaymentMethod,
    required this.status,
    required this.errorText,
    required this.isOnClick,
    required this.order,
  });

  const PaymentState.initial()
      : status = PaymentStatus.initial,
        selectedPaymentMethod = '',
        errorText = '',
        isOnClick = false,
        order = null;

  PaymentState copyWith({
    String? selectedPaymentMethod,
    PaymentStatus? status,
    String? errorText,
    bool? isOnClick,
    Order? order,
  }) {
    return PaymentState(
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
      isOnClick: isOnClick ?? this.isOnClick,
      order: order ?? this.order,
    );
  }
}
