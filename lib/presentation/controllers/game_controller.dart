// lib/presentation/controllers/game_controller.dart
import 'dart:async';
import 'package:get/get.dart';
import 'package:learn_1/data/models/resource_model.dart';
import 'package:learn_1/domain/entities/pet.dart';
import 'package:learn_1/domain/entities/resource_data.dart';
import 'package:learn_1/domain/entities/resource.dart';
import 'package:learn_1/domain/usecase/apply_resource.dart';
import 'package:learn_1/domain/usecase/buy_resource.dart';
import 'package:learn_1/domain/usecase/unlock_resource.dart';

class GameController extends GetxController {
  // Observables
  var coins = 100.obs;
  var stars = 0.obs;
  var pets = <Rx<Pet>>[].obs; // Menggunakan Rx<Pet> untuk setiap pet
  var selectedPet = Rx<Rx<Pet>?>(null); // Ubah dari Rx<Pet?> menjadi Rx<Rx<Pet>?>

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
      pets.forEach((rxPet) {
        Pet pet = rxPet.value;
        pet.energy = (pet.energy - 1).clamp(0, 100);
        pet.cleanliness = (pet.cleanliness - 1).clamp(0, 100);
        pet.happiness = (pet.happiness - 1).clamp(0, 100);
        rxPet.refresh(); // Memicu update untuk pet tertentu
        print(
            'Pet ${pet.name} stats updated: Energy=${pet.energy}, Cleanliness=${pet.cleanliness}, Happiness=${pet.happiness}');
      });
    });
  }

  void fetchPets() async {
    List<Pet> fetchedPets = await buyResource.repository.getPets();
    pets.assignAll(fetchedPets.map((pet) => pet.obs).toList());
    if (fetchedPets.isNotEmpty) {
      selectedPet.value = pets.first; // Tetapkan pet pertama sebagai selectedPet
      print('Pets fetched: ${fetchedPets.length}');
    } else {
      // Jika tidak ada pet, Anda bisa menambahkan pet default atau menampilkan pesan
      print('No pets fetched.');
    }
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

  // Menambahkan metode buyResourceAction
  void buyResourceAction(ResourceModel resource) {
    if (coins.value >= resource.cost) {
      coins.value -= resource.cost;
      switch (resource.type) {
        case 'food':
          foodAmount.value += 1;
          break;
        case 'grooming':
          groomingAmount.value += 1;
          break;
        case 'play':
          playAmount.value += 1;
          break;
        default:
          print('Unknown resource type: ${resource.type}');
      }
      Get.snackbar('Resource Purchased',
          'You purchased 1 ${resource.name}.',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Insufficient Coins', 'You do not have enough coins.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Mengubah metode untuk menerima pet target
  void applyResourceToPet(Rx<Pet> targetPet, String resourceType, int amount) {
    print(
        'applyResourceToPet called with resourceType: $resourceType, amount: $amount for Pet: ${targetPet.value.name}');

    if (targetPet.value == null) {
      Get.snackbar('No Pet', 'Selected pet is null.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    Pet pet = targetPet.value;

    switch (resourceType) {
      case 'food':
        if (foodAmount.value >= amount) {
          pet.energy = (pet.energy + 10 * amount).clamp(0, 100);
          pet.happiness = (pet.happiness + 5 * amount).clamp(0, 100);
          foodAmount.value -= amount;
          print('Applied $amount Food to ${pet.name}');
        } else {
          Get.snackbar('Insufficient Food', 'You do not have enough food.',
              snackPosition: SnackPosition.BOTTOM);
          return;
        }
        break;
      case 'grooming':
        if (groomingAmount.value >= amount) {
          pet.cleanliness = (pet.cleanliness + 10 * amount).clamp(0, 100);
          pet.happiness = (pet.happiness + 5 * amount).clamp(0, 100);
          groomingAmount.value -= amount;
          print('Applied $amount Grooming to ${pet.name}');
        } else {
          Get.snackbar('Insufficient Grooming',
              'You do not have enough grooming kits.',
              snackPosition: SnackPosition.BOTTOM);
          return;
        }
        break;
      case 'play':
        if (playAmount.value >= amount) {
          pet.happiness = (pet.happiness + 10 * amount).clamp(0, 100);
          pet.energy = (pet.energy - 5 * amount).clamp(0, 100);
          playAmount.value -= amount;
          print('Applied $amount Play to ${pet.name}');
        } else {
          Get.snackbar('Insufficient Play',
              'You do not have enough play resources.',
              snackPosition: SnackPosition.BOTTOM);
          return;
        }
        break;
      default:
        print('Unknown resource type: $resourceType');
        Get.snackbar('Error', 'Unknown resource type.',
            snackPosition: SnackPosition.BOTTOM);
        return;
    }

    Get.snackbar('Resource Applied',
        'You applied $amount $resourceType to ${pet.name}',
        snackPosition: SnackPosition.BOTTOM);
    targetPet.refresh(); // Memicu refresh pada pet yang di-update
  }

  // Method to select a pet (for navigation to environment)
  void selectPet(Rx<Pet> pet) {
    selectedPet.value = pet;
    // Navigate to environment page
    Get.toNamed('/environment');
  }
}
