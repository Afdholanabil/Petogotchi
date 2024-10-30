// lib/presentation/widgets/top_bar.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_1/data/models/resource_model.dart';
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
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.purple,
      child: Column(
        children: [
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
                  Obx(() => CurrencyButton(
                        icon: Icons.star,
                        label: gameController.stars.value.toString(),
                        color: Colors.orange,
                      )),
                ],
              ),
              // Membungkus setiap ResourceButton dengan Obx
              Obx(() => ResourceButton(
                    icon: Icons.fastfood,
                    label: 'Food',
                    amount: gameController.foodAmount.value,
                    color: Colors.red,
                    onTap: () {
                      print('Food button tapped');
                      gameController.buyResourceAction(
                        ResourceModel(name: 'Food', cost: 10, type: 'food'),
                      );
                    },
                  )),
              Obx(() => ResourceButton(
                    icon: Icons.cleaning_services,
                    label: 'Groom',
                    amount: gameController.groomingAmount.value,
                    color: Colors.blue,
                    onTap: () {
                      print('Groom button tapped');
                      gameController.buyResourceAction(
                        ResourceModel(name: 'Grooming Kit', cost: 15, type: 'grooming'),
                      );
                    },
                  )),
              Obx(() => ResourceButton(
                    icon: Icons.toys,
                    label: 'Play',
                    amount: gameController.playAmount.value,
                    color: Colors.green,
                    onTap: () {
                      print('Play button tapped');
                      gameController.buyResourceAction(
                        ResourceModel(name: 'Toy', cost: 20, type: 'play'),
                      );
                    },
                  )),
            ],
          ),
          SizedBox(height: 30),
          // Lower Layer: Pet Selection and Stats
          Expanded(
            child: Obx(() {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: gameController.pets.length,
                itemBuilder: (context, index) {
                  Pet pet = gameController.pets[index];
                  return PetButton(
                      pet: pet,
                      isSelected: gameController.selectedPet.value == pet);
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
