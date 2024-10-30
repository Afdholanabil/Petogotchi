import '../models/pet_model.dart';
import '../models/resource_model.dart';

abstract class PetRemoteDataSource {
  Future<List<PetModel>> fetchPets();
  Future<List<ResourceModel>> fetchResources();
  Future<void> purchaseResource(ResourceModel resource);
  Future<void> applyResourceToPet(String resourceType, PetModel pet);
  Future<void> unlockPet(PetModel pet);
  // Add more methods as needed
}

class PetRemoteDataSourceImpl implements PetRemoteDataSource {
  @override
  Future<List<PetModel>> fetchPets() async {
    // Mock data for prototyping
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return [
      PetModel(
        name: 'Fluffy',
        image: 'assets/images/pets/luna.png',
        environment: 'Home',
      ),
      PetModel(
        name: 'Whiskers',
        image: 'assets/images/pets/cat.png',
        environment: 'Park',
      ),
      // Add more pets as needed
    ];
  }

  @override
  Future<List<ResourceModel>> fetchResources() async {
    // Mock data for prototyping
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return [
      ResourceModel(name: 'Food', cost: 10, type: 'food'),
      ResourceModel(name: 'Grooming Kit', cost: 15, type: 'grooming'),
      ResourceModel(name: 'Toy', cost: 20, type: 'play'),
    ];
  }

  @override
  Future<void> purchaseResource(ResourceModel resource) async {
    // Implement purchase logic, e.g., update backend or local storage
    await Future.delayed(Duration(milliseconds: 500));
  }

  @override
  Future<void> applyResourceToPet(String resourceType, PetModel pet) async {
    // Implement apply logic, e.g., update backend or local storage
    await Future.delayed(Duration(milliseconds: 500));
    switch (resourceType) {
      case 'food':
        pet.feed();
        break;
      case 'grooming':
        pet.groom();
        break;
      case 'play':
        pet.play();
        break;
      default:
        break;
    }
  }

  @override
  Future<void> unlockPet(PetModel pet) async {
    // Implement unlock pet logic
    await Future.delayed(Duration(milliseconds: 500));
  }
}
