import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemCategory extends StatelessWidget {
  final String name;
  const ItemCategory({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtHooMD36gfYIjXy3Vhz0kvW_S6s4qBwQY4A&usqp=CAU',
            width: 72,
            height: 72,),
          ),
          backgroundColor: Colors.grey,
        ),
        Text(name)
      ],
    );
  }
}
