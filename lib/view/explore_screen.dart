import 'package:carx/components/item_post.dart';

import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return const PostItem();
        },
        itemCount: 10,
      ),
    );
  }
}
