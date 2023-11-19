import 'package:carx/utilities/app_colors.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
      ),
      body: const Center(
        child: Text(
          'No posts',
          style: TextStyle(fontSize: 14, color: AppColors.grey),
        ),
      ),
    );
  }
}
