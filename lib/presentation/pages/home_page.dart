// lib/presentation/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_1/presentation/widgets/pet_button.dart';
import 'package:learn_1/presentation/widgets/top_bar.dart';
import '../controllers/game_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GameController gameController = Get.find<GameController>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0),
        child: TopBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Pet selection area

            SizedBox(height: 20),
            // Other page content (e.g., Educational Area)
            Text('Educational Area Placeholder'),
            ElevatedButton(
              onPressed: () {
                gameController.earnCoins(10); // Example action
              },
              child: Text('Complete Math Activity'),
            ),
            Obx(() =>
                Text('Coins Earned Today: ${gameController.coins.value}')),
          ],
        ),
      ),
    );
  }
}
