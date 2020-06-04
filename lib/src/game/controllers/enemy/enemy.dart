import 'dart:math';
import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flameTest/src/components/base/mixins/destroy_able.dart';
import 'package:flameTest/src/components/base/mixins/gun_able.dart';
import 'package:flameTest/src/components/base/mixins/hit_able.dart';
import 'package:flameTest/src/components/base/mixins/move_able.dart';
import 'package:flameTest/src/components/base/spritable.dart';
import 'package:flameTest/src/game/main_game_controller.dart';
import 'package:flameTest/src/game/utils/utils.dart';

class Enemy extends Spritable with MoveAble,DestroyAble,HitAble,GunAble {
  bool isOnDie = false;
  int scoreValue = 0;
  Enemy(Vector2 initialPosition, Size tileSize, {Vector2 pivot, int scoreValue}) : super(initialPosition: initialPosition, ){
    gameEventOnBulletUpdate = GameEvent.ENEMY_BULLET_UPDATE;
    gunDirection = Utils.DOWN;
    bulletVelocity = 3;
    isAlive = true;
    spritePaint = Paint();
    spritePaint.color = Color(0xff6ab04c);
    spriteRect = Rect.fromLTWH(position.x,position.y,this.tileSize.width,this.tileSize.height);
    this.scoreValue = scoreValue ?? GameController.rand.nextInt(1000);
    frames = position.x * position.y/3;
  }

  double frames = 0;

  @override
  void update(double t) {
    if(isAlive){
      frames += t;
      spriteRect = spriteRect.inflate(sin(15 * frames) * 0.15);
    }
    super.update(t);
  }

  bool isPressed(Offset tapPos){
    return spriteRect.contains(tapPos);
  }

  die() {
    if(!isOnDie){
      print(['enemy', this.hashCode,'die']);
      isOnDie = true;
      GameController.tapEvent.add(GameEvent(GameEvent.DESTROYED, this));
    }
  }

}