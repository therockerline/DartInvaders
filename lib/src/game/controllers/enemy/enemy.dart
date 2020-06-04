import 'dart:async';
import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flameTest/src/components/base/mixins/destroy_able.dart';
import 'package:flameTest/src/components/base/mixins/hit_able.dart';
import 'package:flameTest/src/components/base/spritable.dart';
import 'package:flameTest/src/game/main_game_controller.dart';

class Enemy extends Spritable with HitAble,DestroyAble {
  bool isOnDie = false;
  int scoreValue = 0;
  Enemy(Vector2 initialPosition, Size tileSize, {Vector2 pivot, int scoreValue}) : super(initialPosition: initialPosition, ){
    isAlive = true;
    spritePaint = Paint();
    spritePaint.color = Color(0xff6ab04c);
    spriteRect = Rect.fromLTWH(position.x,position.y,this.tileSize.width,this.tileSize.height);
    this.scoreValue = scoreValue ?? GameController.rand.nextInt(1000);
  }
  double count = 0;
  void update(double t) {
    if(isOnDie){
      count += t * 2;
      spriteRect = spriteRect.deflate(t * 5);
      spritePaint.color = Color(0xff0000).withAlpha((255 / count).round());
      if(count > 1){
        spritePaint.color = Color(0x00ff0000);
        count = 0;
        destroy();
      }
    }
  }

  bool isPressed(Offset tapPos){
    return spriteRect.contains(tapPos);
  }

  die() {
    isOnDie = true;
    GameController.tapEvent.add(GameEvent(GameEvent.DESTROYED, this));
  }

}