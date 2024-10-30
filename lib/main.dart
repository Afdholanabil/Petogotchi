import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flame/flame.dart';
import 'package:flutter/services.dart';
import 'presentation/controllers/game_controller.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/store_page.dart';
import 'presentation/pages/pet_environment_page.dart';
import 'presentation/bindings/game_binding.dart';
import 'presentation/bindings/store_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Enforce portrait orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Flame in portrait mode
  await Flame.device.fullScreen();
  await Flame.device.setPortrait();

  runApp(PetogotchiApp());
}

class PetogotchiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Petogotchi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
          binding: GameBinding(),
        ),
        GetPage(
          name: '/store',
          page: () => StorePage(),
          binding: StoreBinding(),
        ),
        GetPage(
          name: '/environment',
          page: () => PetEnvironmentPage(),
          binding: GameBinding(),
        ),
      ],
    );
  }
}
