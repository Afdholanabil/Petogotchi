// lib/domain/usecases/unlock_pet.dart
import '../entities/pet.dart';
import '../repositories/pet_repository.dart';

class UnlockPet {
  final PetRepository repository;

  UnlockPet(this.repository);

  Future<void> execute(Pet pet) async {
    await repository.unlockPet(pet);
  }
}
