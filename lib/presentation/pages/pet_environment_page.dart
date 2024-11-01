// lib/presentation/pages/pet_environment_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/game_controller.dart';
import '../../domain/entities/pet.dart';

class PetEnvironmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GameController gameController = Get.find<GameController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Environment'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Obx(() {
          Rx<Pet>? selectedPet = gameController.selectedPet.value;
          if (selectedPet == null) {
            return Text('No Pet Selected');
          }
          Pet pet = selectedPet.value;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                pet.image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                pet.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // Tambahkan informasi atau interaksi lainnya di sini
              Text('Energy: ${pet.energy}'),
              Text('Cleanliness: ${pet.cleanliness}'),
              Text('Happiness: ${pet.happiness}'),
            ],
          );
        }),
      ),
    );
  }
}
