import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

class Bird extends SpriteComponent with CollisionCallbacks{
  // initialize bird position and size
  Bird() : super(position: Vector2(birdStartX, birdStartY), size: Vector2(birdWidth, birdHeight));

  // physical world properties
  double velocity = 0;
  final double gravity = 800;
  final double jumpStrength = -300;

  // load bird 
  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load("bird.png");

    // add collision hit box
    add(RectangleHitbox());
  }

  // make bird flap
  void flap(){
    velocity = jumpStrength;
  }

  @override
  void update(double dt) {
    // apply gravity
    velocity += gravity * dt;

    // update bird's position based on current velocity
    position.y += velocity * dt;
  }

  // check collision with ground
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // check if the bird collides with the ground
    if(other is Ground){
      (parent as FlappyBirdGame).gameOver();
    }

    if(other is Pipe){
       (parent as FlappyBirdGame).gameOver();
    }

  }
}
