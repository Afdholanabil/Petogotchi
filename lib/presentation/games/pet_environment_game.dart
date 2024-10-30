// lib/presentation/game/pet_environment_game.dart

import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/pet.dart';

class PetEnvironmentGame extends FlameGame {
  final Pet pet;
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
    // Load environment background
    environmentBackground = SpriteComponent()
      ..sprite = await _loadSprite('assets/images/environments/$environment.png') // Pastikan path benar
      ..size = size
      ..position = Vector2.zero();

    add(environmentBackground);

    // Load pet sprite
    petComponent = SpriteComponent()
      ..sprite = await _loadSprite(pet.image)
      ..size = Vector2(100, 100)
      ..position = Vector2(size.x / 2 - 50, size.y / 2 - 50);

    add(petComponent);
  }

  Future<Sprite> _loadSprite(String path) async {
    final image = await images.load(path);
    return Sprite(image);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Update environment-specific animations if needed
  }
}
