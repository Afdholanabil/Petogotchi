// lib/presentation/widgets/top_bar.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_1/domain/entities/pet.dart';
import 'package:learn_1/presentation/widgets/Button/currency_button.dart';
import '../controllers/game_controller.dart';
import 'resource_button.dart';
import 'pet_button.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GameController gameController = Get.find<GameController>();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      color: Colors.purple,
      child: Column(
        children: [
          // Bar untuk Coins dan Stars
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Obx(() => CurrencyButton(
                        icon: Icons.monetization_on,
                        label: gameController.coins.value.toString(),
                        color: Colors.yellow,
                      )),
                  SizedBox(height: 5),
                  Obx(() => CurrencyButton(
                        icon: Icons.star,
                        label: gameController.stars.value.toString(),
                        color: Colors.orange,
                      )),
                ],
              ),
              // Resource Buttons
              Obx(() => ResourceButton(
                    icon: Icons.fastfood,
                    label: 'Food',
                    amount: gameController.foodAmount.value,
                    color: Colors.red,
                    resourceType: 'food',
                  )),
              Obx(() => ResourceButton(
                    icon: Icons.cleaning_services,
                    label: 'Groom',
                    amount: gameController.groomingAmount.value,
                    color: Colors.blue,
                    resourceType: 'grooming',
                  )),
              Obx(() => ResourceButton(
                    icon: Icons.toys,
                    label: 'Play',
                    amount: gameController.playAmount.value,
                    color: Colors.green,
                    resourceType: 'play',
                  )),
            ],
          ),
          SizedBox(height: 30),
          // Pet Button sebagai Drop Target dan Selector
          Container(
            height: 150,
            child: Obx(() {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: gameController.pets.length,
                itemBuilder: (context, index) {
                  Rx<Pet> pet = gameController.pets[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: PetButton(
                      pet: pet,
                      isSelected: gameController.selectedPet.value?.value.name == pet.value.name,
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
