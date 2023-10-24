// ignore_for_file: use_build_context_synchronously

import 'package:carx/data/model/car_detail.dart';
import 'package:carx/utilities/dialog/error_order_dialog.dart';
import 'package:carx/utilities/dialog/success_order_dialog.dart';
import 'package:flutter/material.dart';

class OrderNotifier with ChangeNotifier {
 
  String address;
 
  DateTime? fromTime;
  DateTime? endTime;
  double amount;
  int dayRent;
  OrderNotifier({
   
    this.address = '',
    this.amount = 0,
    this.dayRent = 1,
  });

  void updateAddress(String value) {
    address = value;
    notifyListeners();
  }

  void updateAmount(double value) {
    amount = value;
    notifyListeners();
  }

  Future<void> showFromDateTimePicker(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: fromTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      final selectedTime = await showTimePicker(
        context: context,
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
        notifyListeners();
      }
    }
  }

  Future<void> showEndDateTimePicker(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: endTime ?? fromTime!.add(const Duration(days: 1)),
      firstDate: fromTime!.add(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      final selectedTime = await showTimePicker(
        context: context,
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
        Duration duration = endTime!.difference(fromTime!);
        dayRent = duration.inDays.toInt();
        notifyListeners();
      }
    }
  }

  void isCheck(BuildContext context, CarDetail cars) {
    if (address.isEmpty) {
      showErrorOrderDialog(context: context, content: 'Address empty');
    }else if (fromTime == null) {
       showErrorOrderDialog(context: context, content: 'fromTime empty');
    } else if (endTime == null) {
      showErrorOrderDialog(context: context, content: 'endTime empty');
    }else{
      showBookingSuccessDialog(context: context, content: 'Success');
    }
  }
}
