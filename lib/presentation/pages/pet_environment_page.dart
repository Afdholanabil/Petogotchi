// lib/presentation/pages/pet_environment_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_1/presentation/controllers/game_controller.dart';
import 'package:flame/game.dart';
import 'package:learn_1/presentation/games/pet_environment_game.dart';

class PetEnvironmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GameController gameController = Get.find<GameController>();
    final selectedPet = gameController.selectedPet.value;

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedPet!.value.name}\'s Environment'),
      ),
      body: GameWidget(
        game: PetEnvironmentGame(
          pet: selectedPet,
          environment: selectedPet.value.environment, // Menggunakan environment dari pet
        ),
      ),
    );
  }
}
