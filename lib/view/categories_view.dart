import 'package:carousel_slider/carousel_slider.dart';
import 'package:carx/view/home_view.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  int _currentItem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CategoriesView(),
                  ));
                },
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Color.fromARGB(255, 236, 235, 235)),
                  child: const TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                        hintText: 'Search...',
                        enabled: false,
                        prefixIcon:
                            Icon(Icons.search, size: 24, color: Colors.black54),
                        suffixIcon: Icon(Icons.filter_list,
                            size: 24, color: Colors.black54),
                        border: InputBorder.none),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      pauseAutoPlayOnTouch: true,
                      aspectRatio: 16 / 9,
                      height: 145,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentItem = index;
                        });
                      },
                    ),
                    items: urlImages.map((urlImage) {
                      return Builder(
                        builder: (context) {
                          return Image.network(
                            urlImage,
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: DotsIndicator(
                      dotsCount: urlImages.length,
                      position: _currentItem,
                      decorator: DotsDecorator(
                        activeColor: Colors.white,
                        color: Colors.grey,
                        size: const Size.square(6.0),
                        activeSize: const Size(12.0, 6.0),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Text(
                'Vehicle Type List',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 145,
                    mainAxisExtent: 140,
                    childAspectRatio: 1.0,
                    mainAxisSpacing: 12.0,
                    crossAxisSpacing: 24.0),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        width: 115,
                        height: 115,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: Color(0xffe5e5e5),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnWdGlIWqDWXWpYEhrwj_cMmPHnkQd1TnioA&usqp=CAU',
                          
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Item $index'),
                    ],
                  );
                },
                itemCount: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
