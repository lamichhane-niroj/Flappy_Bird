import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

class Ground extends SpriteComponent
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  Ground() : super();

  // load sprite and set position
  @override
  FutureOr<void> onLoad() async {
    size = Vector2(2 * gameRef.size.x, groundHeight);
    position = Vector2(0, gameRef.size.y - groundHeight);

    sprite = await Sprite.load("ground.png");

    // add a collision box around ground
    add(RectangleHitbox());
  }

  // move ground to the left
  @override
  void update(double dt) {
    position.x -= groundMoveVelocity * dt;

    // reset if it goes off screen
    if (position.x + size.x / 2 <= 0) {
      position.x = 0;
    }
  }
}
