// lib/domain/repositories/pet_repository.dart
import '../entities/pet.dart';
import '../entities/resource.dart';

abstract class PetRepository {
  Future<void> purchaseResource(Resource resource);
  Future<void> applyResourceToPet(String resourceType, Pet pet);
  Future<void> earnStars(int amount);
  Future<void> spendStars(int amount);
  Future<List<Pet>> getPets();
  Future<void> unlockPet(Pet pet);

  
}
