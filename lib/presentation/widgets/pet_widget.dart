// lib/presentation/widgets/pet_widget.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/game_controller.dart';
import '../../domain/entities/pet.dart';

class PetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GameController gameController = Get.find<GameController>();

    return Obx(() {
      if (gameController.pets.isEmpty) {
        // Tampilkan indikator loading saat pets masih kosong
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      // Akses pet pertama setelah memastikan list tidak kosong
      Pet pet = gameController.pets.first;

      return GestureDetector(
        onTap: () {
          gameController.selectPet(pet);
        },
        child: DragTarget<String>(
          onWillAccept: (data) => data != null,
          onAccept: (resourceType) {
            print('Dropped $resourceType on pet');
            gameController.applyResourceToPet(resourceType);
          },
          builder: (context, candidateData, rejectedData) {
            bool isHovering = candidateData.isNotEmpty;
            return Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(pet.image),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  color: isHovering ? Colors.green : Colors.transparent,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        _buildStatBar('Energy', Colors.blue, pet.energy),
                        _buildStatBar('Cleanliness', Colors.green, pet.cleanliness),
                        _buildStatBar('Happiness', Colors.pink, pet.happiness),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildStatBar(String label, Color color, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      child: Row(
        children: [
          Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
          SizedBox(width: 4),
          Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey[300],
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: value / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 4),
          Text('$value', style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}
