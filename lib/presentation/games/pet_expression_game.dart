// lib/presentation/game/pet_expression_game.dart
import 'package:flame/game.dart';
import 'package:flame/components.dart';

class PetExpressionGame extends FlameGame {
  final String emotionImage;
  late SpriteComponent emotionComponent;

  PetExpressionGame({required this.emotionImage});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Use the correct method to load the sprite
    // lib/presentation/game/pet_expression_game.dart
    final sprite = await loadSprite(emotionImage);

    emotionComponent = SpriteComponent()
      ..sprite = sprite
      ..size = Vector2(50, 50)
      ..position = Vector2(size.x / 2 - 25, size.y / 2 - 25);

    add(emotionComponent);
  }
}
