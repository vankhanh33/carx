import 'package:carx/components/item_car.dart';
import 'package:carx/features/search/ui/search_view.dart';

import 'package:flutter/material.dart';

class TopDealsView extends StatefulWidget {
  const TopDealsView({super.key});

  @override
  State<TopDealsView> createState() => _TopDealsViewState();
}

class _TopDealsViewState extends State<TopDealsView> {
  SearchController searchController = SearchController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Deals'),
        elevation: 1,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchView(),
                ));
              },
              icon: Icon(Icons.search)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: const BoxDecoration(
                            color: Colors.amber,
                            borderRadius:
                                BorderRadius.all(Radius.circular(999))),
                        margin: const EdgeInsets.all(4),
                        child: Center(
                          child: index % 2 == 0
                              ? Text('Lamborghini Aventador $index')
                              : Text('Item $index'),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Text("data");
                },
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisExtent: 280,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                  maxCrossAxisExtent: 300,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
