import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flameTest/src/components/base/mixins/destroy_able.dart';
import 'package:flameTest/src/components/base/mixins/gun_able.dart';
import 'package:flameTest/src/components/base/mixins/hit_able.dart';
import 'package:flameTest/src/components/base/mixins/move_able.dart';
import 'package:flameTest/src/components/base/spritable.dart';
import 'package:flameTest/src/game/main_game_controller.dart';
import 'package:flameTest/src/game/utils/utils.dart';

class Player extends Spritable with  MoveAble,DestroyAble,HitAble,GunAble{
  int totalLife = 1;
  int currentLife = 0;

  Player(Vector2 initialPosition, Size tileSize, {Vector2 pivot}) : super(initialPosition: initialPosition, spritePath: 'assets/images/player.png'  ){

    gameEventOnBulletUpdate = GameEvent.PLAYER_BULLET_UPDATE;
    gunDirection = Utils.UP;
    bulletVelocity = 10;
    bulletSize = Size(10,10);

    currentLife = totalLife;

    isAlive = true;
    velocity = 300;
    spritePaint = Paint();
    spritePaint.color = Color(0xffffb04c);
    spriteRect = Rect.fromLTWH(position.x,position.y,this.tileSize.width,this.tileSize.height);
  }

  void die() {
    if(!isOnDie){
      isOnDie = true;
    }
  }



}