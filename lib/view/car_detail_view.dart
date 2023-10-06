// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarDetailView extends StatefulWidget {
  const CarDetailView({Key? key}) : super(key: key);

  @override
  _CarDetailViewState createState() => _CarDetailViewState();
}

class _CarDetailViewState extends State<CarDetailView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String dropdownValue = list.first;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
        child: Stack(children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      'https://cdn.pixabay.com/photo/2017/09/03/00/44/png-2709031_1280.png',
                      width: MediaQuery.of(context).size.width,
                      height: 256,
                      fit: BoxFit.fill,
                    ),
                    AppBar(
                      actions: [
                        IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset('assets/svg/favorite.svg')),
                      ],
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32)),
                  ),
                  padding: EdgeInsets.only(top: 24, left: 12, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lamborghini Aventador 12',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lamborghini',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star_half_sharp),
                              SizedBox(height: 8),
                              Text(
                                '4.5 | Preview',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Specifications',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemExtent: 134,
                          itemBuilder: (context, index) {
                            return const Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 3),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Engine type',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              Color.fromARGB(255, 95, 94, 94)),
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      'Gasoline',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: 4,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Car Renter',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                child: Image.network(
                                    'https://cdn.pixabay.com/photo/2017/09/03/00/44/png-2709031_1280.png'),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              const Text(
                                'Khanh Super Car',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                child: const Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Icon(Icons.phone, size: 28),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              GestureDetector(
                                child: const Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Icon(Icons.message, size: 28),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Desciption',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        textTest,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: Colors.white,
                      child: SizedBox(
                        height: 42,
                        child: Center(
                          child: DropdownButton(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            value: dropdownValue,
                            onChanged: (String? value) {
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: list.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            underline: const SizedBox(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      width: 172,
                      height: 42,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        child: RichText(
                          text: const TextSpan(
                              text: 'Book Now',
                              children: <TextSpan>[
                                TextSpan(text: ' | '),
                                TextSpan(text: '1300\$'),
                              ],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              )),
        ]),
      ),
    );
  }
}

const textTest =
    'Một phiên bản mới của TeX được viết lại từ đầu và gọi là TeX82 do được xuất bản vào năm 1982. Trong số những thay đổi đáng chú ý có, thuật toán gạch nối ban đầu đã được thay thế bằng một thuật toán mới được viết bởi Frank Liang. TeX82 cũng sử dụng số học cố định điểm thay vì dấu phẩy động, để đảm bảo khả năng tái tạo kết quả trên phần cứng máy tính khác nhau và bao gồm một ngôn ngữ lập trình Turing hoàn chỉnh. Năm 1989, Donald Knuth phát hành phiên bản mới của TeX và METAFONT. Mặc dù mong muốn giữ cho chương trình ổn định, Knuth nhận ra rằng 128 ký tự khác nhau cho đầu vào văn bản không đủ để chứa ngôn ngữ nước ngoài; thay đổi chính trong phiên bản 3.0 của TeX là khả năng làm việc với đầu vào 8 bit, cho phép thực hiện 256 ký tự khác nhau trong đầu vào văn bản.';
const List<String> list = <String>['1 sesson', '1 day', '1 week', 'other'];
