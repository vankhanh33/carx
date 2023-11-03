
import 'package:carx/data/features/order_success/order_success_view.dart';
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
                builder: (context) => OrderSucess(),
              ));
            },
            child: Text('Views'),
          )
        ],
      );
    },
  );
}
