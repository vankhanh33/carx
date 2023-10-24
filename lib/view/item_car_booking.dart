import 'package:cached_network_image/cached_network_image.dart';
import 'package:carx/data/model/car.dart';
import 'package:flutter/material.dart';

class CarItemBooking extends StatefulWidget {
  const CarItemBooking({super.key});

  @override
  State<CarItemBooking> createState() => _CarItemBookingState();
}

class _CarItemBookingState extends State<CarItemBooking> {
  Car car = const Car(
    id: 1,
    name: 'Lamborghini Aventador',
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnXyTnqLzaNnwcB3sY01Rn5_AY-14hdc5JLg&usqp=CAU",
    price: 199,
    brand: 'Lamborghini',
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: const BoxDecoration(
        color: Color.fromARGB(26, 189, 188, 188),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Color(0xffe0e3e7),
                ),
                padding: EdgeInsets.all(4),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://cdn.mobilecity.vn/mobilecity-vn/images/2023/08/hinh-nen-genshin-impact-4k-pc-10-jpeg.jpg",
                  width: 54,
                  height: 54,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car.name,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.card_membership_sharp),
                        const SizedBox(width: 4),
                        Text(
                          car.brand,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                              ),
                              child: const Text('View'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          itemDetail(context, 'ID Order', '#025638aA1251'),
          const SizedBox(height: 12),
          itemDetail(context, 'Total Amount', '\$199.00'),
          const SizedBox(height: 12),
          itemDetail(context, 'Status', 'Waiting'),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget itemDetail(BuildContext context, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
