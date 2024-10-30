// lib/presentation/controllers/game_controller.dart

import 'dart:async';
import 'package:get/get.dart';
import 'package:learn_1/data/models/resource_model.dart';
import 'package:learn_1/domain/usecase/apply_resource.dart';
import 'package:learn_1/domain/usecase/buy_resource.dart';
import 'package:learn_1/domain/usecase/unlock_resource.dart';
import '../../domain/entities/pet.dart';
import '../../domain/entities/resource.dart';

class GameController extends GetxController {
  // Observables
  var coins = 100.obs;
  var stars = 0.obs;
  var pets = <Pet>[].obs;
  var selectedPet = Rx<Pet?>(null);

  // Add resource amounts
  var foodAmount = 0.obs;
  var groomingAmount = 0.obs;
  var playAmount = 0.obs;

  final BuyResource buyResource;
  final ApplyResource applyResource;
  final UnlockPet unlockPet;

  Timer? _statTimer;

  GameController({
    required this.buyResource,
    required this.applyResource,
    required this.unlockPet,
  }) {
    print('GameController initialized');
  }

  @override
  void onInit() {
    super.onInit();
    fetchPets();
    _startStatTimer();
  }

  @override
  void onClose() {
    _statTimer?.cancel();
    super.onClose();
  }

  void _startStatTimer() {
    _statTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      pets.forEach((pet) {
        pet.energy = (pet.energy - 1).clamp(0, 100);
        pet.cleanliness = (pet.cleanliness - 1).clamp(0, 100);
        pet.happiness = (pet.happiness - 1).clamp(0, 100);
      });
      update(); // Update the UI if using GetBuilder or similar
    });
  }

  void fetchPets() async {
    List<Pet> fetchedPets = await buyResource.repository.getPets();
    pets.assignAll(fetchedPets);
    selectedPet.value = fetchedPets.first; // Tetapkan pet pertama sebagai selectedPet
  }

  void earnCoins(int amount) {
    coins.value += amount;
    // Persist coins if using storage
  }

  void spendCoins(int amount) {
    if (coins.value >= amount) {
      coins.value -= amount;
      // Persist coins if using storage
    } else {
      Get.snackbar('Insufficient Coins', 'You do not have enough coins.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void earnStars(int amount) {
    stars.value += amount;
    // Persist stars if using storage
  }

  void spendStars(int amount) {
    if (stars.value >= amount) {
      stars.value -= amount;
      // Persist stars if using storage
    } else {
      Get.snackbar('Insufficient Stars', 'You do not have enough stars.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void buyResourceAction(ResourceModel resource) {
    print('buyResourceAction called with resource: ${resource.name}');
    try {
      if (coins.value >= resource.cost) {
        print('Sufficient coins: ${coins.value}, cost: ${resource.cost}');
        coins.value -= resource.cost;
        print('Coins after purchase: ${coins.value}');

        switch (resource.type) {
          case 'food':
            foodAmount.value++;
            print('Food amount: ${foodAmount.value}');
            break;
          case 'grooming':
            groomingAmount.value++;
            print('Grooming amount: ${groomingAmount.value}');
            break;
          case 'play':
            playAmount.value++;
            print('Play amount: ${playAmount.value}');
            break;
          default:
            print('Unknown resource type: ${resource.type}');
            break;
        }
        Get.snackbar('Purchase Successful', 'You bought ${resource.name}',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        print('Insufficient coins: ${coins.value}, required: ${resource.cost}');
        Get.snackbar('Insufficient Coins', 'You do not have enough coins.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e, stackTrace) {
      print('Error in buyResourceAction: $e');
      print(stackTrace);
      Get.snackbar('Error', 'An unexpected error occurred.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Implement method to apply resource via drag and drop
  void applyResourceToPet(String resourceType) {
    switch (resourceType) {
      case 'food':
        pets.first.energy = (pets.first.energy + 10).clamp(0, 100);
        pets.first.happiness = (pets.first.happiness + 5).clamp(0, 100);
        print('Energy after feeding: ${pets.first.energy}');
        print('Happiness after feeding: ${pets.first.happiness}');
        break;
      case 'grooming':
        pets.first.cleanliness = (pets.first.cleanliness + 10).clamp(0, 100);
        pets.first.happiness = (pets.first.happiness + 5).clamp(0, 100);
        print('Cleanliness after grooming: ${pets.first.cleanliness}');
        print('Happiness after grooming: ${pets.first.happiness}');
        break;
      case 'play':
        pets.first.happiness = (pets.first.happiness + 10).clamp(0, 100);
        pets.first.energy = (pets.first.energy - 5).clamp(0, 100);
        print('Happiness after playing: ${pets.first.happiness}');
        print('Energy after playing: ${pets.first.energy}');
        break;
      default:
        print('Unknown resource type: $resourceType');
        break;
    }
    Get.snackbar('Resource Applied', 'You applied $resourceType to ${pets.first.name}',
        snackPosition: SnackPosition.BOTTOM);
    update(); // Memicu rebuild UI
  }

  // Method to select a pet (for navigation to environment)
  void selectPet(Pet pet) {
    selectedPet.value = pet;
    // Navigate to environment page
    Get.toNamed('/environment');
  }
}
