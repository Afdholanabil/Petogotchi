// lib/presentation/widgets/pet_button.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/game_controller.dart';
import '../../domain/entities/pet.dart';
import '../../domain/entities/resource_data.dart';

class PetButton extends StatelessWidget {
  final Rx<Pet> pet; // Rx<Pet>
  final bool isSelected;

  PetButton({required this.pet, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final GameController gameController = Get.find<GameController>();

    return DragTarget<ResourceData>(
      onWillAccept: (data) => data != null && data.amount > 0,
      onAccept: (data) {
        print('Resource of amount ${data.amount} dropped on ${pet.value.name}');
        gameController.applyResourceToPet(pet, data.resourceType, data.amount);
      },
      builder: (context, candidateData, rejectedData) {
        bool isHovering = candidateData.isNotEmpty;

        return Obx(() {
          Pet currentPet = pet.value;
          return Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isHovering ? Colors.green : Colors.transparent,
                width: 3,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Gambar Pet dengan ukuran lebih kecil
                Image.asset(
                  currentPet.image,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 8),
                // Stat Bars dibungkus dalam Flexible agar fleksibel
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildStatBar('Energy', Colors.red, currentPet.energy),
                      _buildStatBar(
                          'Cleanliness', Colors.blue, currentPet.cleanliness),
                      _buildStatBar(
                          'Happiness', Colors.green, currentPet.happiness),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  Widget _buildStatBar(String label, Color color, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 1.0, horizontal: 8.0), // Dikurangi
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: $value',
            style: TextStyle(fontSize: 10, color: Colors.white), // Dikurangi
          ),
          SizedBox(height: 2),
          LinearProgressIndicator(
            value: value / 100,
            backgroundColor: Colors.grey[300],
            color: color,
            minHeight: 10,
          ),
        ],
      ),
    );
  }
}
