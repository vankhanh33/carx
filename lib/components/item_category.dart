import 'package:carx/constants/navigation_controller.dart';
import 'package:carx/data/model/brand.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemCategory extends StatelessWidget {
  final Brand brand;
  const ItemCategory({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    MainController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            if (brand.name == 'All') controller.updateItem(1);
          },
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(999)),
                color: Color(0xffe5e5e5)),
            padding: const EdgeInsets.all(12),
            child: FadeInImage(
              placeholder:
                  const AssetImage('assets/images/xcar-full-black.png'),
              image: NetworkImage(brand.image),
              width: 32,
              height: 32,
              fit: BoxFit.contain,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/xcar-full-black.png',
                  width: 32,
                  height: 32,
                  fit: BoxFit.contain,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 4),
        Center(
          child: Text(
            brand.name,
            style: const TextStyle(
                fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
            maxLines: 1,
          ),
        )
      ],
    );
  }
}
