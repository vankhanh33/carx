
import 'package:carx/view/order/confirm_payment_view.dart';
import 'package:flutter/material.dart';

Future<void> showBookingSuccessDialog({
  required BuildContext context,
  required String content,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Booking success'),
        content: Text('content'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Back'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ConfirmPaymentView(),
              ));
            },
            child: Text('Views'),
          )
        ],
      );
    },
  );
}
