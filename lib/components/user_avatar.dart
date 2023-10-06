import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double size;
  const UserAvatar({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(9999)),
      child: Image.network(
        'data:image/jpeg;base64,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',
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}