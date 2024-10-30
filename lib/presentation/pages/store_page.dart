// lib/presentation/pages/store_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_1/presentation/controllers/game_controller.dart';
import '../controllers/store_controller.dart';
import '../../domain/entities/resource.dart';
import '../../domain/entities/pet.dart';

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final StoreController storeController = Get.find<StoreController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Store'),
        bottom: TabBar(
          tabs: [
            Tab(text: 'Resources'),
            Tab(text: 'Decorations'),
            Tab(text: 'Accessories'),
            Tab(text: 'New Pets'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          StoreCategory(category: 'Resources'),
          StoreCategory(category: 'Decorations'),
          StoreCategory(category: 'Accessories'),
          StoreCategory(category: 'New Pets'),
        ],
      ),
    );
  }
}

class StoreCategory extends StatelessWidget {
  final String category;

  StoreCategory({required this.category});

  @override
  Widget build(BuildContext context) {
    final StoreController storeController = Get.find<StoreController>();
    final GameController gameController = Get.find<GameController>();

    List<dynamic> items = [];

    switch (category) {
      case 'Resources':
        items = storeController.availableResources;
        break;
      case 'Decorations':
        items = storeController.availableDecorations;
        break;
      case 'Accessories':
        items = storeController.availableAccessories;
        break;
      case 'New Pets':
        items = storeController.availablePets;
        break;
      default:
        items = [];
    }

    return Obx(() {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];
          if (category == 'Resources') {
            Resource resource = item as Resource;
            return ListTile(
              leading: Icon(_getIconForCategory(category)),
              title: Text(resource.name),
              subtitle: Text('${resource.cost} Coins'),
              trailing: ElevatedButton(
                onPressed: () {
                  storeController.purchaseResource(resource);
                },
                child: Text('Buy'),
              ),
            );
          } else if (category == 'New Pets') {
            Pet pet = item as Pet;
            return ListTile(
              leading: Icon(_getIconForCategory(category)),
              title: Text(pet.name),
              subtitle: Text('Unlock with Stars'),
              trailing: ElevatedButton(
                onPressed: () {
                  storeController.unlockNewPet(pet);
                },
                child: Text('Unlock'),
              ),
            );
          } else {
            // Handle Decorations and Accessories similarly
            return ListTile(
              leading: Icon(_getIconForCategory(category)),
              title: Text(item['name']),
              subtitle: Text('${item['price']} ${item['currency']}'),
              trailing: ElevatedButton(
                onPressed: () {
                  if (category == 'Decorations') {
                    storeController.purchaseDecoration(item);
                  } else if (category == 'Accessories') {
                    storeController.purchaseAccessory(item);
                  }
                },
                child: Text('Buy'),
              ),
            );
          }
        },
      );
    });
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'Resources':
        return Icons.build;
      case 'Decorations':
        return Icons.dehaze;
      case 'Accessories':
        return Icons.accessibility;
      case 'New Pets':
        return Icons.pets;
      default:
        return Icons.shopping_bag;
    }
  }
}
