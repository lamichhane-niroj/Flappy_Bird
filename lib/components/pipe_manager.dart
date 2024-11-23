import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

class PipeManager extends Component with HasGameRef<FlappyBirdGame> {
  // spawn multiple pipes
  double pipeSpawnTimer = 0;

  @override
  void update(double dt) {
    pipeSpawnTimer += dt;
    const double pipeInterval = 2;

    if (pipeSpawnTimer > pipeInterval) {
      pipeSpawnTimer = 0;
      spawnPipe();
    }
  }

  // spawn new pipes
  void spawnPipe() {
    final double screenHeight = gameRef.size.y;
    const double pipeGap = 150;
    const double pipeWidth = 60;

    // minimum possible height
    const double minPipeHeight = 50;

    // maximum possible height
    final double maxPipeHeight =
        screenHeight - groundHeight - pipeGap - minPipeHeight;

    // randomize the height
    final double bottomPipeHeight =
        minPipeHeight + Random().nextDouble() * (maxPipeHeight - minPipeHeight);

    // height of top pipe
    final double topPipeHeight =
        screenHeight - groundHeight - bottomPipeHeight - pipeGap;

    // create bottom pipe
    final bottomPipe = Pipe(
        Vector2(gameRef.size.x, screenHeight - groundHeight - bottomPipeHeight),
        Vector2(pipeWidth, bottomPipeHeight),
        isTopPipe: false);
  
    // create top pipe
    final topPipe = Pipe(
        Vector2(gameRef.size.x, 0),
        Vector2(pipeWidth, topPipeHeight),
        isTopPipe: true);

    gameRef.add(bottomPipe);
    gameRef.add(topPipe);
  }
}
