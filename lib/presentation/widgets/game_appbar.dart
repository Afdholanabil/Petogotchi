// lib/presentation/widgets/game_app_bar.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/game_controller.dart';
import 'top_bar.dart';

class GameAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GameController gameController = Get.find<GameController>();

    return AppBar(
      flexibleSpace: Column(
        children: [
          TopBar(),
          // Additional game components can be added here
        ],
      ),
      backgroundColor: Colors.blueAccent,
      elevation: 4.0,
    );
  }
}
