import 'package:carx/components/item_car.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  SearchController searchController = SearchController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchAnchor(
          searchController: searchController,
          isFullScreen: true,
          viewShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
          ),
          viewHintText: 'Search....',
          viewTrailing: [
            IconButton(
              onPressed: () {
                searchController.clear();
              },
              icon: const Icon(Icons.clear),
            ),
            IconButton(
              onPressed: () {
                searchController.closeView(searchController.text);
              },
              icon: const Icon(Icons.search),
            ),
          ],
          builder: (context, controller) {
            return SearchBar(
              controller: controller,
              focusNode: FocusNode(),
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              hintText: 'Search....',
              trailing: const [
                Icon(
                  Icons.search_rounded,
                  color: Colors.grey,
                ),
              ],
              onTap: () {
                controller.openView();
              },
              onChanged: (_) {
                controller.openView();
              },
              shape: MaterialStateProperty.all(
                const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
              ),
            );
          },
          suggestionsBuilder: (context, controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = 'Car super $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                  });
                },
              );
            });
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: const UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black12),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: IconButton.styleFrom(backgroundColor: Colors.black),
        ),
        leadingWidth: 30,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (searchController.text.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: 'Result for',
                        children: [
                          TextSpan(text: ' " '),
                          TextSpan(text: 'Lamborghini'),
                          TextSpan(text: ' " '),
                        ],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(text: '1'),
                          TextSpan(text: ' '),
                          TextSpan(text: 'found'),
                        ],
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ItemCar();
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
