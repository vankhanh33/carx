import 'package:cached_network_image/cached_network_image.dart';
import 'package:carx/bloc/user/user_bloc.dart';
import 'package:carx/bloc/user/user_event.dart';
import 'package:carx/bloc/user/user_state.dart';
import 'package:carx/data/model/car.dart';
import 'package:carx/service/api/reponsitory/reponsitory.dart';
import 'package:carx/service/auth/firebase_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarRentalBookingDetail extends StatefulWidget {
  const CarRentalBookingDetail({super.key});

  @override
  State<CarRentalBookingDetail> createState() => _CarRentalBookingDetailState();
}

class _CarRentalBookingDetailState extends State<CarRentalBookingDetail> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          car.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$ ${car.price}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.access_time_filled_rounded,
                                color: Colors.redAccent,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Text(
                                  '0d 12h 34m',
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xffe0e3e7),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: FadeInImage(
                      placeholder:
                          const AssetImage('assets/images/xcar-full-black.png'),
                      image: NetworkImage(car.image),
                      height: 64,
                      width: 64,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              color: Color(0xffe0e3e7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(text: 'ID Order - '),
                        TextSpan(text: '#554812aAfd1e'),
                      ],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const Icon(Icons.share_outlined),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: tracks.map((e) => itemTrack(context, e)).toList(),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              color: Color(0xffe0e3e7),
              child: const Text(
                'Shipping Details',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            BlocBuilder<UserBloc, UserState>(
              bloc: UserBloc(Reponsitory.response(), FirebaseAuthProvider())
                ..add(FetchUser()),
              builder: (context, state) {
                if (state is UserLoading) {
                  return const CircularProgressIndicator();
                } else if (state is UserSuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          state.user.name!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          state.user.address!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Text(
                              'Mobile: ',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              state.user.phone!,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              color: Color(0xffe0e3e7),
              child: const Text(
                'Rental Period',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Start time',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '20-10-2023 11:00:05',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'End time',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '31-10-2023 11:00:05',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              color: Color(0xffe0e3e7),
              child: const Text(
                'Payment Details',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xffe0e3e7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        'assets/svg/payment.svg',
                        width: 48,
                        height: 48,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Text(
                      'Vietcombank',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Price',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '\$ 199.00',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Delivery Charges',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    'FREE',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.green),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discount',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '0',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 2,
              thickness: 2,
              color: Color(0xffe0e3e7),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '\$204.00',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                          child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.red),
                      )),
                      overlayColor:
                          MaterialStatePropertyAll(Colors.transparent),
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                    child: VerticalDivider(
                      width: 20,
                      thickness: 1,
                      color: Color(0xffe0e3e7),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                          child: Text('Support',
                              style: TextStyle(
                                color: Colors.blue,
                              ))),
                      overlayColor:
                          MaterialStatePropertyAll(Colors.transparent),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemTrack(BuildContext context, TrackOrder track) {
    final processes = track.processes;
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Color(0xFF00AA07),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 2,
              height: 77,
              decoration: BoxDecoration(
                color: Color(0xFF00AA07),
              ),
            ),
            Visibility(
              visible: track == tracks[tracks.length - 1],
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFF00AA07),
                  shape: BoxShape.circle,
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  track.title,
                  style: const TextStyle(fontSize: 14),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
                    child: Text(
                      track.processes![index],
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF585858),
                      ),
                    ),
                  ),
                  itemCount: processes?.length,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

final tracks = [
  TrackOrder(title: 'Rented', processes: [
    'Booking confirmed',
    'Distributor is handling vehicle reservations'
  ]),
  TrackOrder(title: 'Inprogress', processes: [
    'Accept car reservations',
    'Prepare to deliver the car to you'
  ]),
  TrackOrder(title: 'Shipped', processes: [
    'Vehicle is delivered',
  ]),
  TrackOrder(title: 'Completed', processes: [
    'Rental Successfully Completed',
    'The vehicle has been returned to the distributor'
  ]),
];

class TrackOrder {
  String title;
  List<String>? processes;
  TrackOrder({required this.title, this.processes});
}

void main() {
  runApp(MaterialApp(
    home: CarRentalBookingDetail(),
  ));
}
