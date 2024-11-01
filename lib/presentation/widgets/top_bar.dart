// lib/presentation/widgets/top_bar.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_1/domain/entities/pet.dart';
import 'package:learn_1/presentation/widgets/Button/combined_currency_button.dart';
import '../controllers/game_controller.dart';
import 'resource_button.dart';
import 'pet_button.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GameController gameController = Get.find<GameController>();
    final screenWidth = MediaQuery.of(context).size.width;

    // Tentukan proporsi lebar
    final currencyFlex = 1; // Flex untuk CombinedCurrencyButton
    final resourceFlex = 1; // Flex untuk setiap ResourceButton
    final resourceButtonsCount = 3; // Jumlah ResourceButton
    final totalSpacing = 8.0 * (resourceButtonsCount - 1); // Total spasi antar ResourceButton

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      color: Colors.purple,
      child: Column(
        children: [
          Row(
            children: [
              // CombinedCurrencyButton dibungkus dalam Flexible
              Flexible(
                flex: currencyFlex,
                child: CombinedCurrencyButton(),
              ),
              SizedBox(width: 8), // Spasi antara Currency dan Resource Buttons

              // ResourceButtons dibungkus dalam Expanded dengan Row internal
              Expanded(
                flex: resourceFlex * resourceButtonsCount,
                child: Row(
                  children: [
                    // ResourceButton 1
                    Expanded(
                      child: Obx(() => ResourceButton(
                            icon: Icons.fastfood,
                            label: 'Food',
                            amount: gameController.foodAmount.value,
                            color: Colors.red,
                            resourceType: 'food',
                            cost: 15,
                            // Lebar akan diatur secara otomatis oleh Expanded
                          )),
                    ),
                    SizedBox(width: 8), // Spasi antar ResourceButtons

                    // ResourceButton 2
                    Expanded(
                      child: Obx(() => ResourceButton(
                            icon: Icons.cleaning_services,
                            label: 'Groom',
                            amount: gameController.groomingAmount.value,
                            color: Colors.blue,
                            resourceType: 'grooming',
                            cost: 12,
                            // Lebar akan diatur secara otomatis oleh Expanded
                          )),
                    ),
                    SizedBox(width: 8), // Spasi antar ResourceButtons

                    // ResourceButton 3
                    Expanded(
                      child: Obx(() => ResourceButton(
                            icon: Icons.toys,
                            label: 'Play',
                            amount: gameController.playAmount.value,
                            color: Colors.green,
                            resourceType: 'play',
                            cost: 10,
                            // Lebar akan diatur secara otomatis oleh Expanded
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          // PetButtons
          SizedBox(
            height: 140,
            child: Obx(() {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: gameController.pets.length,
                itemBuilder: (context, index) {
                  Rx<Pet> pet = gameController.pets[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: GestureDetector(
                      onTap: () {
                        gameController.selectPet(pet);
                      },
                      child: PetButton(
                        pet: pet,
                        isSelected: gameController.selectedPet.value?.value.name ==
                            pet.value.name,
                      ),
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
