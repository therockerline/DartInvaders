import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flameTest/src/components/base/mixins/destroy_able.dart';
import 'package:flameTest/src/components/base/mixins/move_able.dart';
import 'package:flameTest/src/components/base/spritable.dart';
import 'package:flutter/material.dart';

class Bullet extends Spritable with MoveAble,DestroyAble{
  Vector2 direction;
  Bullet(Vector2 initialPosition, this.direction, Size tileSize, {Vector2 pivot, double velocity}): super(initialPosition: initialPosition, tileSize: tileSize){
    isAlive = true;
    spritePaint = Paint();
    spritePaint.color = Color(0xffff0000);
    spriteRect = Rect.fromLTWH(position.x,position.y,this.tileSize.width,this.tileSize.height);
    this.velocity = velocity;
  }

  void update(double t) {
      spriteRect = spriteRect.translate(velocity * direction.x, velocity * direction.y);
      super.update(t);
  }
}