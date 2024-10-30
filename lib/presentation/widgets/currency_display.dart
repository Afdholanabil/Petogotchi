// lib/presentation/widgets/currency_display.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/game_controller.dart';

class CurrencyDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GameController gameController = Get.find<GameController>();

    return Row(
      children: [
        Text(
          '${gameController.coins.value}',
          style: TextStyle(color: Colors.yellow, fontSize: 16),
        ),
        Icon(Icons.monetization_on, color: Colors.yellow),
        SizedBox(width: 10),
        Text(
          '${gameController.stars.value}',
          style: TextStyle(color: Colors.orange, fontSize: 16),
        ),
        Icon(Icons.star, color: Colors.orange),
      ],
    );
  }
}
