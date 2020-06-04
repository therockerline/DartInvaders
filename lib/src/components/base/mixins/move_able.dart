import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flameTest/src/components/base/spritable.dart';
import 'package:flameTest/src/game/main_game_controller.dart';

mixin MoveAble on Spritable{
  double velocity = 5;

  void move(double t, Vector2 direction) {
    Rect futureRect = spriteRect.translate(direction.x * velocity * t, direction.y * velocity * t);
    if(GameController.screenSize.contains(futureRect.centerLeft) && GameController.screenSize.contains(futureRect.centerRight))
      spriteRect = futureRect;
    this.update(t);
  }
}