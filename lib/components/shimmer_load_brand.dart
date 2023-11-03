import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItemCategory extends StatelessWidget {
  final double size;
  const ShimmerItemCategory({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.5),
          highlightColor: Colors.grey,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(999)),
                color: Color(0xffe5e5e5)),
            width: size,
            height: size,
          ),
        ),
        const SizedBox(height: 4),
       
      ],
    );
  }
}
