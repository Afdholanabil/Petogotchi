// lib/presentation/bindings/store_binding.dart
import 'package:get/get.dart';
import 'package:learn_1/data/data_source/pet_remote_data_source.dart';
import 'package:learn_1/data/repositories/pet_repositories_impl.dart';
import 'package:learn_1/domain/usecase/buy_resource.dart';
import 'package:learn_1/domain/usecase/unlock_resource.dart';
import '../controllers/store_controller.dart';

class StoreBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize Data Sources
    Get.lazyPut<PetRemoteDataSource>(() => PetRemoteDataSourceImpl());

    // Initialize Repositories
    Get.lazyPut<PetRepositoryImpl>(() => PetRepositoryImpl(
          remoteDataSource: Get.find<PetRemoteDataSource>(),
        ));

    // Initialize Use Cases
    Get.lazyPut<BuyResource>(() => BuyResource(Get.find<PetRepositoryImpl>()));
    Get.lazyPut<UnlockPet>(() => UnlockPet(Get.find<PetRepositoryImpl>()));

    // Initialize Controllers
    Get.lazyPut<StoreController>(() => StoreController(
          buyResource: Get.find<BuyResource>(),
          unlockPet: Get.find<UnlockPet>(),
        ));
  }
}
