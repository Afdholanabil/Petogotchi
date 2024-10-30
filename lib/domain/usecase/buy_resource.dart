// lib/domain/usecases/buy_resource.dart
import '../entities/resource.dart';
import '../repositories/pet_repository.dart';

class BuyResource {
  final PetRepository repository;

  BuyResource(this.repository);

  Future<void> execute(Resource resource) async {
    await repository.purchaseResource(resource);
  }
}
