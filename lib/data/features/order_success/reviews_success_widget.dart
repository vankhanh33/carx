import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class ReviewSuccessWidget extends StatelessWidget {
  const ReviewSuccessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.green),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(
            'https://assets10.lottiefiles.com/packages/lf20_xlkxtmul.json',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
            frameRate: FrameRate(60),
            repeat: false,
            animate: true,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text(
              'Thank you!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text(
              'Your order has been placed',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

