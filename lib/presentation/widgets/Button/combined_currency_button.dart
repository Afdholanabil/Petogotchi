// lib/presentation/widgets/combined_currency_button.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_1/presentation/controllers/game_controller.dart';

class CombinedCurrencyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GameController gameController = Get.find<GameController>();

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4), // Tambahkan padding agar tidak berdempetan
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // Star Section
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${gameController.stars.value}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Icon(Icons.star, color: Colors.orange, size: 24),
              ],
            );
          }),
          SizedBox(height: 2), // Spasi antara star dan coin
          // Coin Section
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${gameController.coins.value}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Icon(Icons.monetization_on, color: Colors.yellow, size: 24),
              ],
            );
          }),
        ],
      ),
    );
  }
}
