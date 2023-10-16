import 'package:flutter/material.dart';

Future<void> showErrorOrderDialog({
  required BuildContext context,
  required String content,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Booking failed'),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
