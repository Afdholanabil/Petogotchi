// lib/presentation/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/top_bar.dart';
import '../widgets/educational_area.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Tidak perlu memanggil GameController di sini karena sudah di-bind di TopBar
    return Scaffold(
      body: Column(
        children: [
          TopBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Educational Area
                  EducationalArea(),
                  SizedBox(height: 20),
                  // Additional Content
                  Text('Additional Content Placeholder'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
