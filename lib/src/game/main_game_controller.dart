import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/keyboard.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flameTest/src/game/controllers/player/player_controller.dart';
import 'package:flameTest/src/game/controllers/score_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controllers/enemy/enemy_controller.dart';

class KeyEvent{
  String key;
  bool isDown;
  KeyEvent(this.key, this.isDown);
  bool isEqual(KeyEvent ke){
    if(ke == null) return false;
    return ke.key==key && ke.isDown==isDown;
  }
  bool isNotEqual(KeyEvent ke){
    return !isEqual(ke);
  }
}

class GameEvent{
  static final String BULLET_UPDATE = 'BULLET_UPDATE';
  static final String FIRE = 'FIRE';
  static final String TAP = 'TAP';
  static final String KEY = 'KEY';
  static final String DESTROYED = 'DESTROYED';
  String type;
  dynamic value;
  GameEvent(this.type, this.value);
}

class GameController extends Game with KeyboardEvents{
  //Size of the screen from the resize event
  static Size screenSize;
  static Random rand;
  static StreamController<GameEvent> tapEvent = StreamController<GameEvent>.broadcast();
  EnemyController ec;
  PlayerController pc;
  ScoreController sc;
  double tileSize;
  TextConfig config = TextConfig(fontSize: 15.0, fontFamily: 'Awesome Font', color: Colors.white);


  GameController(){
    initialize();
  }

  void initialize() async {
    rand = Random();
    sc = ScoreController();
    pc = PlayerController();
    ec = EnemyController();
    resize(await Flame.util.initialDimensions());
    ec.spawnEnemies();
    pc.spawnPlayer();
  }

  @override
  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff576574);
    canvas.drawRect(bgRect, bgPaint);
    pc.render(canvas);
    ec.render(canvas);
    config.render(canvas, "Enemy: ${ec.enemies.length}", Position(50, screenSize.height - 50), anchor: Anchor.topCenter);
    config.render(canvas, "${sc.score} :Point", Position(screenSize.width - 50, screenSize.height - 50), anchor: Anchor.topCenter);
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width/9;
    super.resize(size);
  }

  @override
  void update(double t) {
    pc.update(t);
    ec.update(t);
  }

  void onTapDown(TapDownDetails d) {
    tapEvent.add(GameEvent(GameEvent.TAP, true));
  }

  void onTapUp(TapDownDetails d) {
    tapEvent.add(GameEvent(GameEvent.TAP, false));
  }

  @override
  void onKeyEvent(RawKeyEvent e) {
    // TODO: implement onKeyEvent
    KeyEvent ev = KeyEvent(e.logicalKey.debugName, e is RawKeyDownEvent);
    if(ev.key!='Space')
      tapEvent.add(GameEvent(GameEvent.KEY, ev));
    else
      tapEvent.add(GameEvent(GameEvent.FIRE, ev.isDown));
  }


}