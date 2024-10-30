// lib/presentation/controllers/store_controller.dart
import 'package:get/get.dart';
import 'package:learn_1/domain/usecase/buy_resource.dart';
import 'package:learn_1/domain/usecase/unlock_resource.dart';
import 'package:learn_1/presentation/controllers/game_controller.dart';
import '../../domain/entities/resource.dart';
import '../../domain/entities/pet.dart';


class StoreController extends GetxController {
  var availableResources = <Resource>[].obs;
  var availablePets = <Pet>[].obs;
  var availableDecorations = <Map<String, dynamic>>[].obs;
  var availableAccessories = <Map<String, dynamic>>[].obs;

  final BuyResource buyResource;
  final UnlockPet unlockPet;

  StoreController({
    required this.buyResource,
    required this.unlockPet,
  });

  @override
  void onInit() {
    super.onInit();
    fetchStoreItems();
  }

  void fetchStoreItems() async {
    // Fetch resources from repository
    availableResources.assignAll([
      Resource(name: 'Food Pack', cost: 50, type: 'food'),
      Resource(name: 'Grooming Kit', cost: 30, type: 'grooming'),
      Resource(name: 'Toy Set', cost: 40, type: 'play'),
    ]);

    // Define Decorations and Accessories statically for prototyping
    availableDecorations.assignAll([
      {'name': 'Sunflower Plant', 'price': 20, 'currency': 'Coins'},
      {'name': 'Cozy Bed', 'price': 35, 'currency': 'Coins'},
      {'name': 'Colorful Rug', 'price': 25, 'currency': 'Coins'},
    ]);

    availableAccessories.assignAll([
      {'name': 'Hat', 'price': 15, 'currency': 'Coins'},
      {'name': 'Glasses', 'price': 10, 'currency': 'Coins'},
      {'name': 'Bow Tie', 'price': 12, 'currency': 'Coins'},
    ]);

    // Fetch available pets
    // lib/presentation/controllers/store_controller.dart
availablePets.assignAll([
  Pet(name: 'Snowball', image: 'assets/images/pets/snowball.png'),
  Pet(name: 'Shadow', image: 'assets/images/pets/shadow.png'),
  Pet(name: 'Luna', image: 'assets/images/pets/luna.png'),
]);

  }

  void purchaseResource(Resource resource) async {
    if (Get.find<GameController>().coins.value >= resource.cost) {
      await buyResource.execute(resource);
      Get.find<GameController>().spendCoins(resource.cost);
      Get.snackbar('Purchase Successful', 'You bought ${resource.name}',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Insufficient Coins', 'You do not have enough coins.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void purchaseDecoration(Map<String, dynamic> decoration) {
    if (Get.find<GameController>().coins.value >= decoration['price']) {
      Get.find<GameController>().spendCoins(decoration['price']);
      // Implement decoration logic, e.g., add to pet's environment
      Get.snackbar('Purchase Successful', 'You bought ${decoration['name']}',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Insufficient Coins', 'You do not have enough coins.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void purchaseAccessory(Map<String, dynamic> accessory) {
    if (Get.find<GameController>().coins.value >= accessory['price']) {
      Get.find<GameController>().spendCoins(accessory['price']);
      // Implement accessory logic, e.g., add to pet's appearance
      Get.snackbar('Purchase Successful', 'You bought ${accessory['name']}',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Insufficient Coins', 'You do not have enough coins.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void unlockNewPet(Pet pet) async {
    if (Get.find<GameController>().stars.value >= 5) { // Example cost
      await unlockPet.execute(pet);
      Get.find<GameController>().spendStars(5);
      fetchStoreItems();
      Get.snackbar('Pet Unlocked', 'You unlocked ${pet.name}',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Insufficient Stars', 'You do not have enough stars.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
