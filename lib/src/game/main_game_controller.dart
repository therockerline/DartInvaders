import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:box2d_flame/box2d.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flameTest/src/components/scrappy_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'controllers/enemy/enemy_controller.dart';


class GameController extends Game with TapDetector, ForcePressDetector{
  //Size of the screen from the resize event
  static Size screenSize;
  static Random rand;
  static StreamController tapEvent = StreamController<Offset>.broadcast();
  EnemyController ec;
  double tileSize;


  GameController(){
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    rand = Random();
    ec = EnemyController();
  }

  @override
  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff576574);
    ScrappyButton resetButton = ScrappyButton(screenSize.width-130, screenSize.height-30,Size(128,28));
    canvas.drawRect(bgRect, bgPaint);
    ec.render(canvas);
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width/9;
    super.resize(size);
  }

  @override
  void update(double t) {
    ec.update(t);
  }

  void onTapDown(TapDownDetails d) {
    tapEvent.add(d.globalPosition);
  }


}