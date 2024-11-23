import 'dart:async';

import 'package:flame/components.dart';
import 'package:flappy_bird/game.dart';
import 'package:flutter/material.dart';

class ScoreText extends TextComponent with HasGameRef<FlappyBirdGame>{
  // init
  ScoreText() : super(text: '0', textRenderer: TextPaint(
    style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold)
  ));

  @override
  FutureOr<void> onLoad() {
    // set the position to the top mid
    position = Vector2((gameRef.size.x - size.x)/2, 50);
  }

  @override
  void update(double dt) {
    final newText = gameRef.score.toString();

    if(text != newText){
      text = newText;
    }
  }

}