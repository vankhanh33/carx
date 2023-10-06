import 'package:flutter/material.dart';

class MyAppp extends StatelessWidget {
  const MyAppp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Dynamic GridView', home: Home());
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("data"),
             Text("data"),

              Text("data"), Text("data"),
               Text("data"), Text("data"), Text("data"), Text("data"), Text("data"), Text("data"), Text("data"),
            itemGrid(width),
          ],
        ),
      ),
    );
  }

  Widget itemGrid(double width) {
    const int count = 16;
    const int itemsPerRow = 2;
    const double ratio = 1 / 1;
    const double horizontalPadding = 0;
    final double calcHeight = ((width / itemsPerRow) - (horizontalPadding)) *
        (count / itemsPerRow).ceil() *
        (1 / ratio);
    return SizedBox(
      width: width,
      height: calcHeight,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
        itemCount: count,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            crossAxisCount: itemsPerRow,
            childAspectRatio: ratio),
        itemBuilder: (context, index) {
          return const SizedBox(
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      "Lorem Ipsum is a dummy text, lorem ipsum",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
