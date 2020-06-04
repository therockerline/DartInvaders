import 'dart:async';
import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flameTest/src/components/actors/bullet/bullet.dart';
import 'package:flameTest/src/components/base/mixins/destroy_able.dart';
import 'package:flameTest/src/components/base/mixins/hit_able.dart';
import 'package:flameTest/src/components/base/mixins/move_able.dart';
import 'package:flameTest/src/components/base/spritable.dart';

class Player extends Spritable with HitAble, MoveAble,DestroyAble{
  int totalLife = 0;
  int currentLife = 0;

  Player(Vector2 initialPosition, Size tileSize, {Vector2 pivot}) : super(initialPosition: initialPosition, spritePath: 'assets/images/player.png'  ){
    isAlive = true;
    velocity = 300;
    spritePaint = Paint();
    spritePaint.color = Color(0xffffb04c);
    spriteRect = Rect.fromLTWH(position.x,position.y,this.tileSize.width,this.tileSize.height);
  }

  void update(double t, Vector2 direction) {
    spriteRect = spriteRect.translate(direction.x * velocity * t, direction.y * velocity * t);
  }

  void die() {
    currentLife = 0;
    destroy();
  }



}