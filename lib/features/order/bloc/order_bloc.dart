// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:math';

import 'package:carx/data/model/order.dart';
import 'package:carx/features/order/bloc/order_event.dart';

import 'package:carx/features/order/bloc/order_state.dart';
import 'package:carx/service/auth/auth_service.dart';
import 'package:carx/features/payment/ui/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderState.initial()) {
    on<DeliveryUpdated>(
      (event, emit) => emit(
        state.copyWith(delivery: event.delivery),
      ),
    );
    on<AddressUpdated>(
      (event, emit) => emit(
        state.copyWith(address: event.address),
      ),
    );
    on<CarUpdated>(
      (event, emit) => emit(
        state.copyWith(car: event.car),
      ),
    );
    on<PriceUpdated>(
      (event, emit) => emit(
        state.copyWith(price: event.price),
      ),
    );
    on<FromTimeUpdated>(
      (event, emit) async => _fetchFromTime(event, emit),
    );
    on<EndTimeUpdated>(
      (event, emit) async => _fetchEndTime(event, emit),
    );
    on<OrderButtonClicked>(
      (event, emit) => _onOrderButtonClick(event, emit),
    );
  }

  void _fetchFromTime(FromTimeUpdated event, Emitter emit) async {
    DateTime? fromTime = state.fromTime;

    final selectedDate = await showDatePicker(
      context: event.context,
      initialDate: fromTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      final selectedTime = await showTimePicker(
        context: event.context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        fromTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        emit(state.copyWith(fromTime: fromTime));
      }
    }
  }

  void _fetchEndTime(EndTimeUpdated event, Emitter emit) async {
    DateTime? endTime = state.endTime;
    DateTime? fromTime = state.fromTime;
    if (fromTime != null) {
      final selectedDate = await showDatePicker(
        context: event.context,
        initialDate: endTime ?? fromTime.add(const Duration(days: 1)),
        firstDate: fromTime.add(const Duration(days: 1)),
        lastDate: DateTime(2100),
      );

      if (selectedDate != null) {
        final selectedTime = await showTimePicker(
          context: event.context,
          initialTime: TimeOfDay.now(),
        );

        if (selectedTime != null) {
          endTime = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
          Duration duration = endTime.difference(fromTime);
          emit(state.copyWith(rentalDuration: duration.inDays));

          int price = event.pricePerDay * state.rentalDuration;
          int totalAmount = price + state.delivery;
          emit(state.copyWith(
            endTime: endTime,
            price: price,
            totalAmount: totalAmount,
          ));
        }
      }
    } else {
      ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
        content: Text('Please choose From Time first!'),
      ));
    }
  }

  void _onOrderButtonClick(OrderButtonClicked event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 5));

    if (state.address.isEmpty) {
      ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
        content: Text('Please add your address before placing an order!'),
      ));
    } else if (state.fromTime == null) {
      ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
        content: Text('Please choose From Time!'),
      ));
    } else if (state.endTime == null) {
      ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
        content: Text('Please choose End Time!'),
      ));
    } else {
      String strFromTime =
          DateFormat('yyyy-MM-dd HH:mm').format(state.fromTime!);
      String strEndTime = DateFormat('yyyy-MM-dd HH:mm').format(state.endTime!);

      String code = generateRandomString(12);
      Order order = Order(
        code: code,
        amount: state.price,
        totalAmount: state.totalAmount,
        fromTime: strFromTime,
        endTime: strEndTime,
        deliveryCharges: state.delivery,
        userId: AuthService.firebase().currentUser!.id,
        status: 'Waiting For Confirmation',
        carId: state.car!.id.toString(),
      );

      Map<String, dynamic> mapOrder = {
        'car': state.car,
        'order': order,
      };
      Navigator.of(event.context).push(MaterialPageRoute(
        builder: (context) => const PaymentSreen(),
        settings: RouteSettings(arguments: mapOrder),
      ));
    }
    emit(state.copyWith(isLoading: false));
  }
}

String generateRandomString(int length) {
  var random = Random.secure();
  var values = List<int>.generate(length, (i) => random.nextInt(256));
  var randomString = base64Url.encode(values);
  return randomString.substring(0, length);
}
