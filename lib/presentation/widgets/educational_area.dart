// lib/presentation/widgets/educational_area.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/game_controller.dart';

class EducationalArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GameController gameController = Get.find<GameController>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Math Educational Activities Area', style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _completeMathActivity(context);
            },
            child: Text('Complete Math Activity'),
          ),
          SizedBox(height: 10),
          Obx(() {
            return Text('Coins Earned Today: ${gameController.coins.value}');
          }),
        ],
      ),
    );
  }

  void _completeMathActivity(BuildContext context) {
    final GameController gameController = Get.find<GameController>();
    gameController.earnCoins(10); // Earn 10 coins per activity
    Get.snackbar('Activity Completed', 'You earned 10 coins!',
        snackPosition: SnackPosition.BOTTOM);
    // TODO: Integrate actual math activities
  }
}
