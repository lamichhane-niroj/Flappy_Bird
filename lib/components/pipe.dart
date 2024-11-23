import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

class Pipe extends SpriteComponent
    with CollisionCallbacks, HasGameRef<FlappyBirdGame> {
  // determine if the pipe is top or bottom
  final bool isTopPipe;
  bool scored = false;

  Pipe(Vector2 position, Vector2 size, {required this.isTopPipe})
      : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(!isTopPipe ? "pipe_top.png": "pipe_bottom.png");

    // add hit box for collision
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    // move pipe to left
    position.x -= groundMoveVelocity * dt;

    // checked if the bird has passed the pipe
    if(!scored && position.x + size.x < gameRef.bird.position.x){
      scored = true;

      if(isTopPipe){
        gameRef.incrementScore();
      }
    }

    // remove pipe if it goes off the screen
    if(position.x + size.x <= 0){
      removeFromParent();
    }
  }
}
