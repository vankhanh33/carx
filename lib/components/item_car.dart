import 'package:carx/data/model/car.dart';
import 'package:carx/features/car_detail/ui/detail_test.dart';
import 'package:flutter/material.dart';

class ItemCar extends StatelessWidget {
  final Car? car;
  const ItemCar({super.key, this.car});

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        if (car != null) {
          print(car?.id.toString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CarDetailView(),
                  settings: RouteSettings(arguments: car?.id)));
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
                child: FadeInImage(
                  placeholder:
                      const AssetImage('assets/images/xcar-full-black.png'),
                  image: NetworkImage('${car?.image}'),
                  height: 150,
                  fit: BoxFit.contain,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/xcar-full-black.png',
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
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star_half_rounded),
                Text('4.5'),
                SizedBox(width: 12),
                Text('|'),
                SizedBox(width: 12),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Colors.grey,
                  ),
                  child: Text('New'),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '\$${car?.price}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
