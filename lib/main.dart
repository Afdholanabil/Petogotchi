// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'presentation/bindings/game_binding.dart';
import 'presentation/bindings/store_binding.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/store_page.dart';
import 'presentation/pages/pet_environment_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pet Game',
      initialBinding: GameBinding(), // Inisialisasi GameBinding
      home: HomePage(),
      getPages: [
        GetPage(
          name: '/store',
          page: () => StorePage(),
          binding: StoreBinding(),
        ),
        GetPage(
          name: '/environment',
          page: () => PetEnvironmentPage(),
          binding: GameBinding(), // Pastikan binding yang sesuai
        ),
        // Tambahkan route lain jika diperlukan
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
