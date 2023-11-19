import 'package:cached_network_image/cached_network_image.dart';
import 'package:carx/data/model/car.dart';

import 'package:carx/utilities/app_routes.dart';
import 'package:carx/utilities/app_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ItemCar extends StatelessWidget {
  final Car? car;
  const ItemCar({super.key, this.car});

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        if (car != null) {
          Navigator.pushNamed(context, Routes.routeCarDetail, arguments: car);
        }
      },
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  placeholder: (context, url) {
                    return shimmerImageCar();
                  },
                  imageUrl: '${car?.image}',
                  height: 150,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      'assets/images/logo-dark.png',
                      height: 150,
                      fit: BoxFit.contain,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${car?.name}',
              style: AppText.subtitle3,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            Text(
              '${car?.brand}',
              style: AppText.body1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              '\$${car?.price}/day',
              style: AppText.subtitle3,
            ),
          ],
        ),
      ),
    );
  }

  Widget shimmerImageCar() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.5),
      highlightColor: Colors.grey,
      child: Image.asset(
        'assets/images/logo-dark.png',
        height: 150,
        fit: BoxFit.contain,
      ),
    );
  }
}
