class Order {
  String? id;
  String? code;
  String? status;
  int? amount;
  int? totalAmount;
  int? deliveryCharges;
  String? startTime;
  String? endTime;
  String? paymentstatus;
  String? paymentMethods;
  String? discountAmount;
  String? carId;
  String? userId;

  Order({
    this.id,
    this.code,
    this.status,
    this.amount,
    this.totalAmount,
    this.deliveryCharges,
    this.startTime,
    this.endTime,
    this.paymentstatus,
    this.paymentMethods,
    this.discountAmount,
    this.carId,
    this.userId,
  });

  @override
  String toString() {
    return '$code - $status - $totalAmount - $amount - $deliveryCharges - $startTime - $endTime - $paymentMethods - $paymentstatus - $carId - $userId';
  }

  Order copyWith({
    String? id,
    String? code,
    String? status,
    int? amount,
    int? totalAmount,
    int? deliveryCharges,
    String? startTime,
    String? endTime,
    String? paymentstatus,
    String? paymentMethods,
    String? discountAmount,
    String? carId,
    String? userId,
  }) =>
      Order(
        id: id ?? this.id,
        code: code ?? this.code,
        status: status ?? this.status,
        amount: amount ?? this.amount,
        totalAmount: totalAmount ?? this.totalAmount,
        deliveryCharges: deliveryCharges ?? this.deliveryCharges,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        paymentstatus: paymentstatus ?? this.paymentstatus,
        paymentMethods: paymentMethods ?? this.paymentMethods,
        discountAmount: discountAmount ?? this.discountAmount,
        carId: carId ?? this.carId,
        userId: userId ?? this.userId,
      );

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    status = json['status'];
    amount = int.tryParse(json['amount']);
    totalAmount = int.tryParse(json['total_amount']);
    deliveryCharges = int.tryParse(json['delivery_charges']);
    startTime = json['start_time'];
    endTime = json['end_time'];
    paymentstatus = json['payment_status'];
    paymentMethods = json['payment_methods'];
    discountAmount = json['discount_amount'];
    carId = json['car_id '];
    userId = json['user_id '];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['status'] = status;
    data['amount'] = amount;
    data['total_amount'] = totalAmount;
    data['delivery_charges'] = deliveryCharges;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['payment_status'] = paymentstatus;
    data['payment_methods'] = paymentMethods;
    data['car_id'] = carId!;
    data['user_id'] = userId;
    data['discount_amount'] = discountAmount ?? '0';

    return data;
  }
}
