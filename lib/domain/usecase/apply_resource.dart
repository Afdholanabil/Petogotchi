// lib/domain/usecases/apply_resource.dart
import '../entities/pet.dart';
import '../repositories/pet_repository.dart';

class ApplyResource {
  final PetRepository repository;

  ApplyResource(this.repository);

  Future<void> execute(String resourceType, Pet pet) async {
    await repository.applyResourceToPet(resourceType, pet);
  }
}
