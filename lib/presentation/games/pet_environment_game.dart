// lib/presentation/game/pet_environment_game.dart

import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/pet.dart';

class PetEnvironmentGame extends FlameGame {
  final Rx<Pet> pet;
  final String environment;
  late SpriteComponent environmentBackground;
  late SpriteComponent petComponent;

  PetEnvironmentGame({
    required this.pet,
    required this.environment,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    try {
      // Load environment background
      environmentBackground = SpriteComponent()
        ..sprite = await _loadSprite('assets/images/environments/$environment.png') // Pastikan path benar
        ..size = size
        ..position = Vector2.zero();

      add(environmentBackground);

      // Load pet sprite
      petComponent = SpriteComponent()
        ..sprite = await _loadSprite(pet.value.image)
        ..size = Vector2(100, 100)
        ..position = Vector2(size.x / 2 - 50, size.y / 2 - 50);

      add(petComponent);
    } catch (e) {
      print('Error loading sprites: $e');
      // Anda bisa menambahkan widget fallback atau pesan error di sini
    }
  }

  Future<Sprite> _loadSprite(String path) async {
    try {
      final image = await images.load(path);
      return Sprite(image);
    } catch (e) {
      print('Error loading sprite from $path: $e');
      // Gunakan placeholder sprite jika diperlukan
      return Sprite(await images.load('assets/images/placeholder.png'));
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Update environment-specific animations jika diperlukan
  }
}
