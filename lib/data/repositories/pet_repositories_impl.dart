// lib/data/repositories/pet_repository_impl.dart
import 'package:learn_1/data/data_source/pet_remote_data_source.dart';

import '../../domain/entities/pet.dart';
import '../../domain/entities/resource.dart';
import '../../domain/repositories/pet_repository.dart';
import '../models/pet_model.dart';
import '../models/resource_model.dart';

class PetRepositoryImpl implements PetRepository {
  final PetRemoteDataSource remoteDataSource;

  PetRepositoryImpl({required this.remoteDataSource});

  // lib/data/repositories/pet_repository_impl.dart
@override
Future<void> purchaseResource(Resource resource) async {
  if (resource is ResourceModel) {
    await remoteDataSource.purchaseResource(resource);
    // Update local state or storage here
  } else {
    throw UnimplementedError();
  }
}


  
  @override
  Future<void> applyResourceToPet(String resourceType, Pet pet) async {
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
    }
    // Optionally, save pet state to persistent storage
  }

  @override
  Future<void> earnStars(int amount) async {
    // Implement earning stars logic, e.g., update backend or local storage
    await Future.delayed(Duration(milliseconds: 500));
  }

  @override
  Future<void> spendStars(int amount) async {
    // Implement spending stars logic, e.g., update backend or local storage
    await Future.delayed(Duration(milliseconds: 500));
  }

  @override
  Future<List<Pet>> getPets() async {
    return await remoteDataSource.fetchPets();
  }

  @override
  Future<void> unlockPet(Pet pet) async {
    if (pet is PetModel) {
      await remoteDataSource.unlockPet(pet);
    } else {
      throw UnimplementedError();
    }
  }
}
