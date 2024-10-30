// lib/presentation/game/pet_game.dart
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import '../../domain/entities/pet.dart';

class PetGame extends FlameGame {
  final Pet pet;
  late SpriteComponent petComponent;

  PetGame({required this.pet});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Load pet sprite
    petComponent = SpriteComponent()
      ..sprite = await loadSprite(pet.image)
      ..size = Vector2(100, 100)
      ..position = Vector2(size.x / 2 - 50, size.y / 2 - 50);

    add(petComponent);
  }
}
