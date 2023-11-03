import 'package:flutter/material.dart';

class NotificationScreeen extends StatelessWidget {
  const NotificationScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Center(
        child: Image.asset(
          'assets/images/no-notify.png',
          width: MediaQuery.of(context).size.width / 1.5,
          height: MediaQuery.of(context).size.width / 1.5,
        ),
      ),
    );
  }
}
